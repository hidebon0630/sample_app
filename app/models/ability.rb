# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user&.admin_flg?

    can :access, :rails_admin
    can :manage, :all
  end
end
