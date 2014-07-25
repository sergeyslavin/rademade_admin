# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Saver

    attr_reader :item

    # Initialization of model saver class
    #
    # @param model_info [RademadeAdmin::Model::Info]
    # @param params [Hash]
    #
    def initialize(model_info, params)
      @model_info = model_info
      @params = params
    end

    def create_model
      @item = @model_info.model.new filter_data_params
    end

    def update_model
      @item = @model_info.model.find( @params[:id] )
      item.update filter_data_params
    end

    def save_model
      item.save @params
    end

    def save_aggregated_data
      save_model_relations
      save_model_uploads
      item.save!
    end

    def errors
      item.errors
    end

    private

    def save_model_relations
      data = @params[:data]
      @model_info.relations.all.each do |name, relation|
        setter = relation.setter
        if data.has_key? setter
          ids = data[ setter ]
          ids.reject! { |id| id.empty? } if ids.kind_of?(Array)
          item.send(setter + '=', ids)
        end
      end
    end

    def save_model_uploads
      data = @params[:data]
      @model_info.uploaders.each do |name, _|
        if data.has_key?(name) and not data[name].blank?
          image_path = CarrierWave.root + data[name].to_s
          setter_method = (name.to_s + '=').to_sym
          begin
            item.send(setter_method, File.open(image_path))
          rescue
            #rm_todo clear image
          end
        end
      end
    end

    def filter_data_params
      @params.require(:data).permit( @model_info.fields.save_form_fields )
    end

  end
end
