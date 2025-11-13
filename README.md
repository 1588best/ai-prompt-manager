# 🚀 AI Prompt Manager

一个帮助用户保存、管理、分享 AI 提示词（Prompts）的工具。

## 📋 功能

### MVP 核心功能

- ✅ 提示词管理（创建、编辑、删除）
- ✅ 分类标签系统
- ✅ 一键复制功能
- ✅ 变量替换（{变量名}）
- ✅ 公共市场浏览
- ✅ 用户认证（Clerk）
- ✅ 订阅计费（Stripe）

## 🛠 技术栈

| 层级       | 技术         | 说明             |
| ---------- | ------------ | ---------------- |
| **前端**   | Next.js 14   | React 框架       |
| **样式**   | Tailwind CSS | 原子 CSS 框架    |
| **组件**   | shadcn/ui    | 高级组件库       |
| **类型**   | TypeScript   | 类型安全         |
| **数据库** | Supabase     | PostgreSQL 服务  |
| **认证**   | Clerk        | 用户认证         |
| **支付**   | Stripe       | 订阅管理         |
| **部署**   | Vercel       | Next.js 官方部署 |

## 🚀 快速开始

### 前置要求

- Node.js 20+
- npm 或 yarn
- Git

### 本地开发

1. **克隆仓库**

```bash
git clone https://github.com/yourusername/ai-prompt-manager.git
cd ai-prompt-manager
```

2. **安装依赖**

```bash
npm install
```

3. **配置环境变量**

```bash
cp .env.example .env.local
# 编辑 .env.local，填入你的 API 密钥
```

4. **启动开发服务器**

```bash
npm run dev
```

访问 [http://localhost:3000](http://localhost:3000)

### 使用 Codespaces

1. 在 GitHub 仓库页面点击 **Code → Codespaces → Create codespace on main**
2. 在 Codespace 中运行：

```bash
npm run setup
```

3. 编辑 `.env.local` 填入 API 密钥
4. 运行 `npm run dev`

## 📁 项目结构

```
.
├── app/                      # Next.js App Router
│   ├── (dashboard)/         # 仪表板路由
│   ├── api/                 # API 路由
│   ├── layout.tsx           # 根布局
│   ├── page.tsx             # 首页
│   └── globals.css          # 全局样式
├── components/              # React 组件
│   └── ui/                  # shadcn/ui 组件
├── lib/                     # 工具库
│   ├── supabase.ts         # Supabase 客户端
│   ├── types.ts            # TypeScript 类型
│   └── utils.ts            # 工具函数
├── public/                  # 静态资源
├── .devcontainer/          # Codespaces 配置
├── scripts/                # 构建脚本
├── package.json            # 项目配置
└── README.md               # 项目文档
```

## 🗄️ 数据库架构

### prompts 表

```sql
CREATE TABLE prompts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  description TEXT,
  category TEXT,
  tags TEXT[],
  is_public BOOLEAN DEFAULT false,
  likes_count INTEGER DEFAULT 0,
  uses_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### user_subscriptions 表

```sql
CREATE TABLE user_subscriptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id TEXT UNIQUE NOT NULL,
  plan TEXT DEFAULT 'free', -- free, pro, enterprise
  stripe_customer_id TEXT,
  stripe_subscription_id TEXT,
  current_period_end TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

## 💳 定价方案

| 功能       | 免费版 | 专业版 ($9/月) | 企业版 ($29/月) |
| ---------- | ------ | -------------- | --------------- |
| 提示词数量 | 10 个  | 无限           | 无限            |
| 公共市场   | ✅     | ✅             | ✅              |
| 变量功能   | ❌     | ✅             | ✅              |
| 团队协作   | ❌     | ❌             | ✅              |
| API 访问   | ❌     | ❌             | ✅              |

## 🔧 可用命令

```bash
# 开发
npm run dev              # 启动开发服务器

# 构建
npm run build            # 构建生产版本
npm start                # 启动生产服务器

# 代码质量
npm run lint             # ESLint 检查

# 初始化
npm run setup            # 完整项目初始化
```

## 📝 环境变量

创建 `.env.local` 文件（复制 `.env.example`）：

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key

# Clerk
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_key
CLERK_SECRET_KEY=your_clerk_secret

# Stripe
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_key
STRIPE_SECRET_KEY=your_stripe_secret
STRIPE_WEBHOOK_SECRET=your_webhook_secret

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

## 🌐 部署到 Vercel

1. 推送代码到 GitHub
2. 在 [vercel.com](https://vercel.com) 导入项目
3. 配置环境变量
4. 部署

```bash
vercel deploy
```

## 📚 相关文档

- [Next.js 文档](https://nextjs.org/docs)
- [Supabase 文档](https://supabase.com/docs)
- [Clerk 文档](https://clerk.com/docs)
- [Stripe 文档](https://stripe.com/docs)
- [Tailwind CSS](https://tailwindcss.com)

## 🤝 贡献

欢迎提交 PR 和 Issue！

## 📄 许可

MIT License

## 🎯 开发路线图

### Day 1-7（MVP）

- [ ] 完成项目搭建
- [ ] 实现认证系统
- [ ] 完成提示词 CRUD
- [ ] 构建公共市场
- [ ] 集成 Stripe 支付
- [ ] 部署到 Vercel

### Week 2-4（增强功能）

- [ ] Chrome 扩展
- [ ] AI 生成提示词
- [ ] 版本控制
- [ ] 团队协作
- [ ] 移动端优化

## 💡 常见问题

### Q: 如何添加新的提示词？

A: 登录后，进入仪表板，点击"新建提示词"按钮。

### Q: 支持 API 吗？

A: 企业版用户可以获得 API 访问权限。

### Q: 如何导出我的提示词？

A: 目前支持复制和下载为 JSON 文件。

---

**开发者**: [@1588best](https://github.com/1588best)
**开源协议**: MIT
**最后更新**: 2025-11-13
