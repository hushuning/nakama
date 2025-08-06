package server

import (
	"context"
	"database/sql"
	"errors"
	"testing"

	"github.com/gofrs/uuid/v5"
	"github.com/heroiclabs/nakama-common/api"
	"github.com/heroiclabs/nakama-common/rtapi"
	"github.com/heroiclabs/nakama-common/runtime"
	"go.uber.org/zap"
	"google.golang.org/grpc/codes"
)

func TestRuntimeGoInitializer_RegisterEvent(t *testing.T) {
	ri := &RuntimeGoInitializer{
		eventFunctions: make([]RuntimeEventFunction, 0),
	}

	fn := func(ctx context.Context, logger runtime.Logger, evt *api.Event) {}
	err := ri.RegisterEvent(fn)
	if err != nil {
		t.Fatalf("RegisterEvent failed: %v", err)
	}

	if len(ri.eventFunctions) != 1 {
		t.Fatalf("Expected 1 event function, got %d", len(ri.eventFunctions))
	}
}

func TestRuntimeGoInitializer_RegisterRpc(t *testing.T) {
	ri := &RuntimeGoInitializer{
		rpc: make(map[string]RuntimeRpcFunction),
	}

	fn := func(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, payload string) (string, error) {
		return "result", nil
	}
	err := ri.RegisterRpc("test", fn)
	if err != nil {
		t.Fatalf("RegisterRpc failed: %v", err)
	}

	if _, ok := ri.rpc["test"]; !ok {
		t.Fatal("RPC function not registered")
	}
}

func TestRuntimeGoInitializer_RegisterBeforeRt(t *testing.T) {
	ri := &RuntimeGoInitializer{
		beforeRt: make(map[string]RuntimeBeforeRtFunction),
	}

	fn := func(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, envelope *rtapi.Envelope) (*rtapi.Envelope, error) {
		return envelope, nil
	}
	err := ri.RegisterBeforeRt("test", fn)
	if err != nil {
		t.Fatalf("RegisterBeforeRt failed: %v", err)
	}

	if _, ok := ri.beforeRt["rtapi.test"]; !ok {
		t.Fatal("BeforeRt function not registered")
	}
}

func TestRuntimeGoInitializer_RegisterAfterRt(t *testing.T) {
	ri := &RuntimeGoInitializer{
		afterRt: make(map[string]RuntimeAfterRtFunction),
	}

	fn := func(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, out, in *rtapi.Envelope) error {
		return nil
	}
	err := ri.RegisterAfterRt("test", fn)
	if err != nil {
		t.Fatalf("RegisterAfterRt failed: %v", err)
	}

	if _, ok := ri.afterRt["rtapi.test"]; !ok {
		t.Fatal("AfterRt function not registered")
	}
}

func TestRuntimeGoInitializer_RegisterBeforeGetAccount(t *testing.T) {
	ri := &RuntimeGoInitializer{
		beforeReq: &RuntimeBeforeReqFunctions{},
	}

	fn := func(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule) error {
		return nil
	}
	err := ri.RegisterBeforeGetAccount(fn)
	if err != nil {
		t.Fatalf("RegisterBeforeGetAccount failed: %v", err)
	}

	if ri.beforeReq.beforeGetAccountFunction == nil {
		t.Fatal("BeforeGetAccount function not registered")
	}
}

func TestRuntimeGoInitializer_RegisterAfterGetAccount(t *testing.T) {
	ri := &RuntimeGoInitializer{
		afterReq: &RuntimeAfterReqFunctions{},
	}

	fn := func(ctx context.Context, logger runtime.Logger, db *sql.DB, nk runtime.NakamaModule, out *api.Account) error {
		return nil
	}
	err := ri.RegisterAfterGetAccount(fn)
	if err != nil {
		t.Fatalf("RegisterAfterGetAccount failed: %v", err)
	}

	if ri.afterReq.afterGetAccountFunction == nil {
		t.Fatal("AfterGetAccount function not registered")
	}
}