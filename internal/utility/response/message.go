package response

var Message = map[Code]string{
	// 通用
	Success:             "请求成功！",
	BadRequest:          "请求格式、参数缺失或者错误！",
	TokenInvalid:        "授权失效！",
	TooManyRequests:     "请求频率超限！",
	UnprocessableEntity: "参数验证错误！",

	//用户

	//订单

}
