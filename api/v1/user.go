package v1

import (
	"github.com/gogf/gf/v2/frame/g"
)

type UserLoginReq struct {
	g.Meta   `method:"post" tags:"UserService" summary:"用户登录"`
	Phone    string `json:"phone" v:"required|phone-loose#手机号码必填|手机号码格式必须正确"`
	Password string `json:"password" v:"required|length:6,16#密码必填|密码长度应当在6到16之间"`
}
type UserLoginRes struct {
	Token    string `json:"token"`
	Id       int64  `json:"userId"      description:"用户ID"`
	NickName string `json:"nickName"   description:"昵称"`
	Avatar   string `json:"avatar"     description:"头像"`
	Gender   int    `json:"gender"     description:"性别 0:保密 1:男 2:女"`
	Type     int    `json:"type"       description:"用户类型 0:普通用户 1:运营用户"`
	Phone    string `json:"phone"      description:"手机号"`
}

type UserSignUpReq struct {
	g.Meta    `method:"post" tags:"UserService" summary:"用户注册"`
	Phone     string `json:"phone" v:"required|phone-loose#手机号码必填|手机号码格式必须正确"`
	Password  string `json:"password" v:"required|length:6,16#密码必填|密码长度应当在6到16之间"`
	Password2 string `json:"password2" v:"required|length:6,16|same:Password"`
	Nickname  string `json:"name"`
}
type UserSignUpRes struct{}

type UserLogoutReq struct {
	g.Meta `method:"post" tags:"UserService" summary:"用户退出登录"`
}

type UserLogoutRes struct {
}

type UserProfileRes struct {
	g.Meta     `method:"post" tags:"UserService" summary:"用户信息"`
	Id         int64  `json:"userId"      description:"用户ID"`
	Phone      string `json:"phone"      description:"手机号"`
	NickName   string `json:"nickName"   description:"昵称"`
	Avatar     string `json:"avatar"     description:"头像"`
	Gender     int    `json:"gender"     description:"性别 0:保密 1:男 2:女"`
	ArticleNum int    `json:"articleNum"   description:"发布文章数量"`
	LikesNum   int    `json:"LikesNum"   description:"点赞数量"`
	LikedNum   int    `json:"LikedNum"   description:"被点赞数量"`
}

type UserJwtReq struct {
	g.Meta `method:"post" tags:"UserService" summary:"用户jwt"`
}
type UserJwtRes struct {
	Token string `json:"token"`
}
