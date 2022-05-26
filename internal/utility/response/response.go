package response

import (
	"github.com/gogf/gf/v2/net/ghttp"
)

type ResponsRes struct {
	// 代码
	Code Code `json:"code"`
	// 消息
	Message string `json:"message"`
	// 数据集
	Data interface{} `json:"data"`
}

var Resp = new(ResponsRes)

// JsonExit 返回JSON数据并退出当前HTTP执行函数。
func (res *ResponsRes) JsonExit(r *ghttp.Request, code Code, msg string, data ...interface{}) {
	res.RJson(r, code, msg, data...)
	r.Exit()
}

// RJson 标准返回结果数据结构封装。
// 返回固定数据结构的JSON:
// code:  状态码(200:成功,和http请求状态码一至);
// message:  请求结果信息;
// data: 请求结果,根据不同接口返回结果的数据结构不同;
func (res *ResponsRes) RJson(r *ghttp.Request, code Code, msg string, data ...interface{}) {
	responseData := interface{}(nil)
	if len(data) > 0 {
		responseData = data[0]
	}
	Resp = &ResponsRes{
		Code:    code,
		Message: msg,
		Data:    responseData,
	}
	r.SetParam("apiReturnRes", Resp)
	_ = r.Response.WriteJson(Resp)
}

// SusJson 成功返回JSON
func (res *ResponsRes) SusJson(r *ghttp.Request, data ...interface{}) {
	res.JsonExit(r, Success, Success.Message(), data...)
}

// FailJson 失败返回JSON
func (res *ResponsRes) FailJson(r *ghttp.Request, code Code, msg string, data ...interface{}) {
	res.JsonExit(r, code, msg, data...)
}
