module JeraPush
  class V1::DevicesController < JeraPush::V1::VersionController

    def create
      @device = JeraPush::Device.find_by(token: params[:token], platform: params[:platform])
      if @device.nil?
        @device = JeraPush::Device.create device_params
      else
        @device.update_attributes(pushable_id: params[:pushable_id], pushable_type: params[:pushable_type])
      end
      render_object(@device)
    end

    def destroy
      @device = JeraPush::Device.find_by(token: params[:token], platform: params[:platform])
      return render_not_found if @device.nil?
      @device.destroy
      render_object(@device)
    end

    private
    def device_params
      params.permit(:token, :platform, :pushable_id, :pushable_type)
    end
  end
end
