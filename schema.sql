-- À coller dans Supabase > SQL Editor > Run (une seule fois)
create table if not exists public.budget (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data    jsonb  not null,
  ts      bigint not null default 0
);

alter table public.budget enable row level security;

create policy "budget_select_own" on public.budget
  for select to authenticated using (auth.uid() = user_id);
create policy "budget_insert_own" on public.budget
  for insert to authenticated with check (auth.uid() = user_id);
create policy "budget_update_own" on public.budget
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
