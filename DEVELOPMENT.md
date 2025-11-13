# 🛠️ 开发指南

## 📦 项目初始化完成

✅ **项目状态**: 已初始化，可以开始开发

### 已完成的设置

- ✅ Next.js 14 项目结构
- ✅ TypeScript 配置
- ✅ Tailwind CSS + PostCSS
- ✅ shadcn/ui 组件库（基础组件）
- ✅ Supabase 集成
- ✅ Clerk 认证集成
- ✅ Stripe 支付集成（配置）
- ✅ ESLint 代码检查
- ✅ Codespaces 开发环境配置
- ✅ 环境变量模板

## 🚀 快速启动指南

### 选项1: 本地开发

```bash
# 1. 安装依赖
npm install

# 2. 配置环境变量
cp .env.example .env.local
# 编辑 .env.local，填入你的 API 密钥

# 3. 启动开发服务器
npm run dev

# 4. 打开浏览器访问
# http://localhost:3000
```

### 选项2: GitHub Codespaces

1. 在 GitHub 上打开仓库
2. 点击 **Code → Codespaces → Create codespace on main**
3. 在 Codespace 中运行：
   ```bash
   npm run setup
   ```
4. 编辑 `.env.local` 填入 API 密钥
5. 运行 `npm run dev`

## 📁 项目结构说明

```
ai-prompt-manager/
├── app/                          # Next.js App Router（路由和页面）
│   ├── api/                      # API 路由
│   │   ├── health/route.ts       # 健康检查端点
│   │   └── prompts/route.ts      # 提示词 API
│   ├── (dashboard)/              # 仪表板路由组
│   │   ├── layout.tsx            # 仪表板布局
│   │   └── page.tsx              # 仪表板首页
│   ├── globals.css               # 全局样式
│   ├── layout.tsx                # 根布局（包含 ClerkProvider）
│   └── page.tsx                  # 首页
│
├── components/                   # React 组件
│   └── ui/                       # shadcn/ui 基础组件
│       ├── button.tsx            # 按钮组件
│       ├── card.tsx              # 卡片组件
│       ├── input.tsx             # 输入框
│       └── textarea.tsx          # 文本区域
│
├── lib/                          # 工具库
│   ├── supabase.ts              # Supabase 客户端初始化
│   ├── types.ts                 # TypeScript 类型定义
│   └── utils.ts                 # 工具函数（如 cn()）
│
├── .devcontainer/                # Codespaces 配置
│   ├── devcontainer.json         # 开发容器配置
│   └── docker-compose.yml        # 可选的数据库配置
│
├── scripts/                      # 脚本
│   └── setup.sh                  # 初始化脚本
│
├── 配置文件
│   ├── tsconfig.json             # TypeScript 配置
│   ├── next.config.js            # Next.js 配置
│   ├── tailwind.config.ts        # Tailwind CSS 配置
│   ├── postcss.config.js         # PostCSS 配置
│   ├── .eslintrc.json            # ESLint 配置
│   ├── components.json           # shadcn/ui 配置
│   ├── .env.example              # 环境变量模板
│   ├── .gitignore                # Git 忽略规则
│   └── package.json              # 项目依赖
│
└── README.md                     # 项目文档
```

## 🔑 环境变量配置

创建 `.env.local` 文件并填入以下内容：

### 1. Supabase 配置
```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGc...
```

[获取 Supabase 密钥](https://app.supabase.com/projects)

### 2. Clerk 配置
```env
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_...
CLERK_SECRET_KEY=sk_test_...
```

[获取 Clerk 密钥](https://dashboard.clerk.com)

### 3. Stripe 配置
```env
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

[获取 Stripe 密钥](https://dashboard.stripe.com)

### 4. 应用配置
```env
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

## 💻 常用命令

```bash
# 开发
npm run dev              # 启动开发服务器（localhost:3000）

# 构建和部署
npm run build            # 构建生产版本
npm start                # 启动生产服务器

# 代码质量
npm run lint             # 运行 ESLint
npm run lint -- --fix    # 自动修复 ESLint 问题

# 初始化
npm run setup            # 完整项目初始化（包含 shadcn/ui）
```

## 🔧 开发工具

### 推荐的 VS Code 扩展
- ESLint - 代码质量
- Prettier - 代码格式化
- Tailwind CSS IntelliSense - 样式自动完成
- TypeScript Vue Plugin - 类型支持

这些扩展已在 `.devcontainer/devcontainer.json` 中配置，Codespaces 会自动安装。

## 📊 数据库设计

### 需要在 Supabase 中创建的表

**1. prompts 表**
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

-- 创建索引
CREATE INDEX idx_prompts_user_id ON prompts(user_id);
CREATE INDEX idx_prompts_is_public ON prompts(is_public);
```

**2. user_subscriptions 表**
```sql
CREATE TABLE user_subscriptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id TEXT UNIQUE NOT NULL,
  plan TEXT DEFAULT 'free',
  stripe_customer_id TEXT,
  stripe_subscription_id TEXT,
  current_period_end TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_user_subscriptions_user_id ON user_subscriptions(user_id);
```

**3. prompt_likes 表**
```sql
CREATE TABLE prompt_likes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id TEXT NOT NULL,
  prompt_id UUID REFERENCES prompts(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, prompt_id)
);

CREATE INDEX idx_prompt_likes_user_id ON prompt_likes(user_id);
CREATE INDEX idx_prompt_likes_prompt_id ON prompt_likes(prompt_id);
```

## 🎯 下一步开发任务

### Day 1-2: 认证系统
- [ ] 实现 Clerk 登录/注册页面
- [ ] 创建受保护的路由
- [ ] 添加用户个人资料页面

### Day 3-4: 提示词管理
- [ ] 创建提示词 CRUD API
- [ ] 构建提示词编辑器 UI
- [ ] 实现提示词列表和搜索

### Day 5-6: 公共市场
- [ ] 实现公共提示词浏览
- [ ] 添加点赞功能
- [ ] 创建搜索和筛选

### Day 7: 支付集成
- [ ] 配置 Stripe 订阅
- [ ] 实现定价页面
- [ ] 添加付费功能限制

## 🐛 调试技巧

### 启用调试模式
```bash
# 在开发时查看详细日志
DEBUG=* npm run dev
```

### Supabase 调试
```typescript
// 在 lib/supabase.ts 中
supabase.auth.onAuthStateChange((event, session) => {
  console.log('Auth event:', event, session)
})
```

### API 测试
```bash
# 测试健康检查
curl http://localhost:3000/api/health

# 测试数据库连接
curl http://localhost:3000/api/prompts
```

## 📚 相关文档和资源

- [Next.js 官方文档](https://nextjs.org/docs)
- [TypeScript 文档](https://www.typescriptlang.org/docs/)
- [Supabase 文档](https://supabase.com/docs)
- [Clerk 文档](https://clerk.com/docs)
- [Stripe 文档](https://stripe.com/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [shadcn/ui](https://ui.shadcn.com/)
- [React Hook Form](https://react-hook-form.com/)

## 🤔 常见问题

### Q: 如何添加新的 shadcn/ui 组件？
```bash
npx shadcn-ui@latest add [组件名]
# 例如：
npx shadcn-ui@latest add dialog
```

### Q: TypeScript 错误怎么办？
```bash
# 检查类型错误
npx tsc --noEmit

# 重新启动 TS 服务器
# 在 VS Code 中：Ctrl+Shift+P -> TypeScript: Restart TS Server
```

### Q: 如何更新依赖？
```bash
npm outdated                # 检查过期包
npm update                  # 更新所有包
npm install [package]@latest # 更新特定包
```

### Q: 如何处理 CORS 错误？
在 `next.config.js` 中配置：
```javascript
async headers() {
  return [
    {
      source: '/api/:path*',
      headers: [
        { key: 'Access-Control-Allow-Origin', value: '*' },
      ],
    },
  ]
}
```

## 🚀 部署清单

### 部署到 Vercel
1. 推送代码到 GitHub
2. 访问 [vercel.com](https://vercel.com)
3. 导入项目
4. 配置环境变量
5. 部署

```bash
vercel deploy --prod
```

### 部署前检查
- [ ] 所有环境变量已配置
- [ ] 代码已通过 ESLint
- [ ] 构建成功 `npm run build`
- [ ] 所有测试通过
- [ ] .env.local 未被提交到 Git

---

**更新日期**: 2025-11-13
**维护者**: [@1588best](https://github.com/1588best)
