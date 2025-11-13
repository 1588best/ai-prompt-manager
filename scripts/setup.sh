#!/bin/bash

echo "🚀 Setting up AI Prompt Manager..."

# 安装依赖
echo "📦 Installing dependencies..."
npm install

# 初始化shadcn/ui
echo "🎨 Setting up shadcn/ui..."
npx shadcn-ui@latest init -y

# 安装必要的shadcn组件
echo "📦 Installing UI components..."
npx shadcn-ui@latest add button card input textarea select dialog dropdown-menu badge toast

# 创建环境变量模板
echo "📝 Creating .env.local template..."
cat > .env.local << EOF
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# Clerk
NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
CLERK_SECRET_KEY=your_clerk_secret_key

# Stripe
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=your_stripe_webhook_secret

# App
NEXT_PUBLIC_APP_URL=http://localhost:3000
EOF

echo "✅ Setup complete! Please update .env.local with your keys."
echo "🚀 Run 'npm run dev' to start the development server."
