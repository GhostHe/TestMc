class Micropost < ActiveRecord::Base


  validates :content, presence: true ,length: { maximum: 140}

  belongs_to :user
  # belongs_to :parent, class_name:"User", foreign_key:"parent_id" # 错误的 ！！！
  has_many :comments
  has_many :goods
  has_many :reports ,dependent: :destroy
  mount_uploader :picture, PictureUploader


  belongs_to :parent,
             :class_name=>"Micropost"     #指明模型名

  has_many :children,                     #固定写法
           :class_name => "Micropost",           #指明模型名
           :foreign_key => 'parent_id',        #指明关联id
           :dependent => :destroy           #删除父节点时删除子节点


end
