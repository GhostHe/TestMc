class Report < ActiveRecord::Base

  enum status: {

    unview: 0,
    viewed: 1,
    deleted: 2,
  }

  belongs_to :user
  belongs_to :micropost

end
