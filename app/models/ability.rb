class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role?('item_alerts', 'manage')
      can :manage, ItemAlert
    end

    if user.has_role?('site', 'pilot')
      can :pilot, 'Analysis'
    end


  end
end
