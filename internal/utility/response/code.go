package response

type Code int

const (
	Success             Code = 200 //请求成功
	BadRequest          Code = 400 //请求格式、参数缺失或者错误
	TokenInvalid        Code = 401 //授权失效
	UnprocessableEntity Code = 422 //参数验证错误
	TooManyRequests     Code = 429 //请求频率超限

	VerifyCodeExpired Code = 10000 //验证码过期
	VerifyCodeError   Code = 10001 //验证码错误
	VerifyCodeTooMany Code = 10002 //验证码次数过多
)

// Message @description: code 对应 massage
func (c Code) Message() string {
	if msg, ok := Message[c]; ok {
		return msg
	}
	return Message[Success]
}
