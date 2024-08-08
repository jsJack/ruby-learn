# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Setup the user and their 1 demo linked social
User.create(full_name: 'Elon Musk', email: 'elon@spacex.com', password: 'HELLOTHISISAPASSWORD', account_type: 'admin')
UserSocial.create(user: User.first, social_type: 'x', url: 'elonmusk')

# Setup site activity by this new demo user
Post.create(title: 'A post by Elon Musk', content: 'This is quite fun! I like this.', user: User.first)
Comment.create(content: 'This is a funny comment by Elon Musk.', post: Post.first, user: User.first)
Like.create(user: User.first, post: Post.first)
