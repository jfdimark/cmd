class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
  :first_name, :last_name, :company, :title, :about_me, :linkedin_profile,
  :twitter_handle, :website, :address_1, :address_2, :town, :city,
  :country, :post_code
  rolify
  attr_accessible :role_ids, :as => :admin

  def linkedin
    linkedin = profile(self.linkedin_profile)
  end

  def profile(url)
    profile = Linkedin::Profile.get_profile(url)
  end
    
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      case auth.provider
      when 'linkedin'
        user.linkedin_profile = auth.info.urls.public_profile
        # user.about_me = auth.extra.raw_info
        # user.num_recommendations = auth.extra(:fields => ["num-recommenders"])
        # user.recommendations = auth.extra(:fields => ["recommendations-received"])
        # user.connections = auth.extra(:fields => ["connections"])
        # user.groups = auth.extra(:fields => ["group-memberships"])
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end


  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


end
