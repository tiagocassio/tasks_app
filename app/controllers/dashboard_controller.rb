# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :set_status

  def index;
  end

  def status
    render json: {
        projects: @projects.count,
        review: @review_tasks.count,
        waiting: @waiting_tasks.count,
        completed: @completed_tasks.count
    }
  end

  private

  def set_status
    @projects = Project.all.includes(:tasks)
    @tasks = Task.all.includes(:project).order(:updated_at)
    @review_tasks = @tasks.review_tasks
    @waiting_tasks = @tasks.waiting_tasks
    @completed_tasks = @tasks.completed_tasks
  end
end
