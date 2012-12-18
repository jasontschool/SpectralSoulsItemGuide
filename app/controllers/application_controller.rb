class ApplicationController < ActionController::Base
    protect_from_forgery
    def silent(str)
        silent_model_eval(str)
    end
    
    def silent_model_eval(str)
        ActiveRecord::Base.logger.silence do
            return eval(str)
        end
    end

    def check_equip(item)
      {:name=> item.name, :equip=>item.equippable?}
    end
end
