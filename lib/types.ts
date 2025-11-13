export type Prompt = {
  id: string;
  user_id: string;
  title: string;
  content: string;
  description?: string;
  category?: string;
  tags: string[];
  is_public: boolean;
  likes_count: number;
  uses_count: number;
  created_at: string;
  updated_at: string;
};

export type UserSubscription = {
  id: string;
  user_id: string;
  plan: "free" | "pro" | "enterprise";
  stripe_customer_id?: string;
  stripe_subscription_id?: string;
  current_period_end?: string;
  created_at: string;
};

export type PromptLike = {
  id: string;
  user_id: string;
  prompt_id: string;
  created_at: string;
};
