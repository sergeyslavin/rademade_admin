# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Uploader

        attr_reader :name, :uploader

        def initialize(name, uploader)
          @name, @uploader = name, uploader
        end
        
        def remove_proc
          method_name = :"remove_#{name}="
          Proc.new do
            self.send(method_name, true)
          end
        end

        def full_path_for(image_path)
          "#{CarrierWave.root}#{image_path}"
        end

      end
    end
  end
end