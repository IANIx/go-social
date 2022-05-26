package cmd

import (
	"context"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gcmd"

	_ "go-social/internal/router"
)

var (
	Main = gcmd.Command{
		Name:  "main",
		Usage: "main",
		Brief: "start http server of simple goframe demos",
		Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {
			s := g.Server()
			s.Use(ghttp.MiddlewareHandlerResponse)
			// Just run the server.
			s.SetPort(8080)
			s.Run()
			return nil
		},
	}
)

// import (
// 	"github.com/gogf/gf/v2/frame/g"
// 	// "github.com/gogf/gf/v2/net/ghttp"
// 	"github.com/gogf/gf/v2/os/glog"
// )

// func init() {
// 	// v := g.View()
// 	c := g.Config()
// 	s := g.Server()
// 	// 模板引擎配置
// 	// v.AddPath("template")
// 	// v.SetDelimiters("${", "}")
// 	// glog配置
// 	logpath := c.GetString("setting.logpath")
// 	glog.SetPath(logpath)
// 	glog.SetStdoutPrint(true)
// 	// Web Server配置
// 	s.SetServerRoot("public")
// 	s.SetLogPath(logpath)
// 	// s.SetNameToUriType(ghttp.NAME_TO_URI_TYPE_ALLLOWER)
// 	s.SetErrorLogEnabled(true)
// 	s.SetAccessLogEnabled(true)
// 	s.SetPort(8080)
// }
