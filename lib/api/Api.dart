class Api {
  // 正式的请求的主域名地址
  static final String FORMAL_HOST = "https://www.oschina.net";
  
  // 测试的请求的主域名地址
  static final String DEV_HOST = "https://www.oschina.net";
  
  // 当前使用的请求的域名地址
  static final String HOST = FORMAL_HOST;

  // 请求的API接口分类
  static final String API_VERSION = "/api/v1";

  // 资讯列表
  static final String NEWS_LIST = "http://osc.yubo725.top/news/list";

  // 资讯详情
  static final String NEWS_DETAIL = HOST + "/action/openapi/news_detail";

  // 动弹列表
  static final String TWEETS_LIST = HOST + "/action/openapi/tweet_list";

  // 评论列表
  static final String COMMENT_LIST = HOST + "/action/openapi/comment_list";

  // 评论回复
  static final String COMMENT_REPLY = HOST + "/action/openapi/comment_reply";

  // 获取用户信息
  static final String USER_INFO = HOST + "/action/openapi/user";

  // 发布动弹
  static final String PUB_TWEET = HOST + "/action/openapi/tweet_pub";

  // 添加到小黑屋
  static final String ADD_TO_BLACK = "http://osc.yubo725.top/black/add";

  // 查询小黑屋
  static final String QUERY_BLACK = "http://osc.yubo725.top/black/query";

  // 从小黑屋中删除
  static final String DELETE_BLACK = "http://osc.yubo725.top/black/delete";

  // 开源活动
  static final String EVENT_LIST = "http://osc.yubo725.top/events/";
}