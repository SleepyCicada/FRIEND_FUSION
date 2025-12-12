# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Friend Fusion is a Rails 7.1 application for organizing language exchange and social events. Users can create/join events, chat with attendees in real-time, and interact with AI-powered features for conversation assistance.

## Common Commands

```bash
# Start development server
bin/rails server

# Database operations
bin/rails db:migrate
bin/rails db:seed
bin/rails db:reset  # Drop, create, migrate, seed

# Rails console
bin/rails console

# Run tests
bin/rails test                           # All tests
bin/rails test test/models/user_test.rb  # Single file
bin/rails test test/models/              # Directory

# Linting
rubocop
rubocop -a  # Auto-fix

# Asset precompilation (production)
bin/rails assets:precompile
```

## Architecture

### Core Domain Models
- **User** - Devise authentication, has many events (as organizer), confirmations, messages
- **Event** - Belongs to Topic and User (organizer), has one Chat, many Confirmations
- **Confirmation** - Join table for event attendance (user joins an event)
- **Chat** - One per event, contains Messages for attendee discussions
- **Message** - Belongs to Chat and User, supports AI-generated messages (`ai` boolean)
- **Topic** - Event categories (language-focused: French, Spanish, etc.)

### AI Features (uses ruby_llm gem)
Services in `app/services/`:
- `AiChatService` - Conversation starters, smart replies, Kai AI assistant, event chat AI
- `AiSummaryService` - Chat summarization
- `AiStarterService` - Generates conversation starters for events

### Real-time Features
- Uses **Solid Cable** (not Redis) for Action Cable in both development and production
- Channels in `app/channels/application_cable/`:
  - `NotificationChannel` - Real-time notifications

### Frontend Stack
- **Hotwire**: Turbo + Stimulus
- **Bootstrap 5** with SCSS
- **ImportMap** for JavaScript (no webpack/esbuild)
- Stimulus controllers in `app/javascript/controllers/`

### Key Patterns
- Authorization via **Pundit** (policies in `app/policies/`)
- Image uploads via **Active Storage** with **Cloudinary** service
- Geocoding for event locations via **Geocoder** gem
- Email previews use **letter_opener** in development

## Styling

All styles use SCSS (not CSS). Stylesheets organized as:
- `app/assets/stylesheets/config/` - Variables, Bootstrap customization
- `app/assets/stylesheets/components/` - Reusable component styles
- `app/assets/stylesheets/pages/` - Page-specific styles

## Environment Variables

Required in `.env`:
- Database credentials (if not using defaults)
- Cloudinary credentials for image uploads
- LLM API credentials for AI features (ruby_llm configuration)
