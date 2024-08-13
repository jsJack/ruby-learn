# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Setup the user and their 1 demo linked social
User.create(full_name: 'Jack Perry', email: 'jack@insiris.com', password: 'HELLOTHISISAPASSWORD', account_type: 'admin')
UserSocial.create(user: User.first, social_type: 'github', url: 'jsJack')

# Setup site activity by this new demo user
Post.create(title: 'My first post', content: 'I am so cool.', user: User.first)
Comment.create(content: 'I commented on my own post, because I am weird.', post: Post.first, user: User.first)
Like.create(user: User.first, post: Post.first)
