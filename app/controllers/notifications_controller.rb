class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :mark_as_read]

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @unread_count = current_user.notifications.where(read: false).count
  end

  def show
    @notification.update(read: true) unless @notification.read?
  end

  def mark_as_read
    if @notification.update(read: true)
      redirect_to notifications_path, notice: "Notification marked as read."
    else
      redirect_to notifications_path, alert: "Unable to mark notification as read."
    end
  end

  def mark_all_as_read
    current_user.notifications.where(read: false).update_all(read: true)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to notifications_path, alert: "Notification not found."
  end
end
