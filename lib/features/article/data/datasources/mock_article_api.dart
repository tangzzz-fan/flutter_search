import '../models/article_model.dart';
import './article_api.dart';

class MockArticleApi implements ArticleApi {
  final _mockArticles = [
    ArticleModel(
      id: 1,
      title: '深入理解 Flutter Clean Architecture',
      body: '''
Clean Architecture 是一种软件架构模式,它将应用程序分为不同的层次,每一层都有其特定的职责。

主要优点包括:
1. 代码结构清晰
2. 易于测试
3. 依赖关系明确
4. 灵活性强

在 Flutter 中实现 Clean Architecture 时,我们通常会划分以下层次:
- Domain Layer: 包含业务逻辑和实体
- Data Layer: 负责数据获取和存储
- Presentation Layer: 处理UI和用户交互
      ''',
      userId: 1,
    ),
    ArticleModel(
      id: 2,
      title: 'Flutter 状态管理之 Riverpod',
      body: '''
Riverpod 是 Flutter 中一个强大的状态管理解决方案,它是 Provider 的重新设计版本。

主要特点:
1. 编译时安全
2. 依赖覆盖
3. 自动缓存
4. 更好的测试支持

使用 Riverpod 可以让我们的代码更加清晰、可维护,并且减少运行时错误。
      ''',
      userId: 1,
    ),
    ArticleModel(
      id: 3,
      title: 'Dio 网络请求最佳实践',
      body: '''
Dio 是一个强大的 Dart HTTP 客户端,它支持拦截器、全局配置、请求取消等功能。

使用 Dio 时的一些建议:
1. 合理使用拦截器
2. 统一错误处理
3. 请求超时设置
4. 数据序列化

本文将介绍如何在实际项目中更好地使用 Dio。
      ''',
      userId: 2,
    ),
    ArticleModel(
      id: 4,
      title: 'Flutter 测试实战指南',
      body: '''
测试是保证应用质量的重要手段,Flutter 提供了完整的测试支持。

测试类型:
1. 单元测试
2. Widget 测试
3. 集成测试

编写好的测试用例可以:
- 提前发现问题
- 防止回归
- 文档化代码行为
- 提高重构信心
      ''',
      userId: 2,
    ),
    ArticleModel(
      id: 5,
      title: 'Flutter 性能优化技巧',
      body: '''
性能优化是 Flutter 开发中的重要话题,本文将分享一些实用的优化技巧。

优化方向:
1. 构建优化
   - 合理使用 const
   - 避免不必要的重建
   
2. 渲染优化
   - 使用 RepaintBoundary
   - 优化图片加载
   
3. 内存优化
   - 及时释放资源
   - 避免内存泄漏
      ''',
      userId: 1,
    ),
  ];

  @override
  Future<List<ArticleModel>> getArticles() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(seconds: 1));
    return _mockArticles;
  }

  @override
  Future<ArticleModel> getArticle(int id) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));

    final article = _mockArticles.firstWhere(
      (article) => article.id == id,
      orElse: () => throw Exception('Article not found'),
    );

    return article;
  }
}
