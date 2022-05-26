package model

type UserCreateInput struct {
	Phone    string
	Password string
	Nickname string
}

type UserSignInInput struct {
	Phone    string
	Password string
}

type UserProfileOuput struct {
	Id         int64 `json:"userId"         description:"用户ID"`
	Phone      string
	Nickname   string
	Avatar     string
	Gender     int
	ArticleNum int
	LikesNum   int
	LikedNum   int
}
