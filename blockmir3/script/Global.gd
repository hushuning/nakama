extends Node

var client : NakamaClient = null
var session : NakamaSession = null
var _api_client : NakamaAPI.ApiClient
var is_login : bool = false
var username : String = ""
