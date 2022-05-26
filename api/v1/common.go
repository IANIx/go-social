package v1

type ListReq struct {
	PageNum  int `p:"pageNum" v:"required#页码必填"`  //当前页码
	PageSize int `p:"pageSize" v:"required#页数必填"` //每页数
}

// ListRes 列表公共返回
type ListRes struct {
	Total       int `json:"total"      description:"总条数"`
	Pages       int `json:"pages"      description:"总页数"`
	CurrentPage int `json:"current_page"      description:"当前页数"`
}
