class Api::V1::ApplicationController < ApplicationController
  respond_to :json

  def self.responder
    ::JsonResponder
  end
end
