class RecordsController < ApplicationController
    # TODO: AUTHORIZE PEOPLE TO MAKE SURE THEY HAVE RECORD RIGHTS
    nested_layouts 'layouts/admin', 'layouts/domain', 'layouts/record', 'layouts/application'
    
    include DomainAuthorization

    def index
        @records = Record.where_host(params[:host])
        @domain = Domain.find_by(host: params['host'])
    end

    def create
        @domain = Domain.find_by(host: params[:host])
        @record = Record.create(domain_id: @domain.id, name: params['name'], type: params['type'], content: params['content'], ttl: params['ttl'], priority: params['priority'])
        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: turbo_stream.append("records", @record)
            end
      
            format.html { redirect_to records_url(@domain) }
        end
    end

    def new
        
    end

    
    def destroy
        @record = Record.find(params["id"].to_i)
        if @record.nil?
            render status: 404, plain: "404 Not Found"
            return
        end
        if(@record.domain_id != Domain.find_by(host: params[:host])&.id)
            render status: 403, plain: "403 Forbidden"
        end

        @domain = Domain.find_by(host: params['host'])

        id = @record.id

        @record.destroy!

        respond_to do |format|
            format.turbo_stream do
              render turbo_stream: turbo_stream.remove("record_#{id}")
            end
      
            format.html { redirect_to records_url(@domain) }
        end
    end

    
    def update
        @record = Record.find(params["id"].to_i)
        @domain = Domain.find_by(host: params['host'])

        
        if @record.nil?
            render status: 404, plain: "404 Not Found"
            return
        end
        if(@record.domain_id != Domain.find_by(host: params[:host])&.id)
            render status: 403, plain: "403 Forbidden"
        end

        @record.type = params[:type]
        @record.name = params[:name]
        @record.content = params[:content]
        @record.ttl = params[:ttl]
        @record.priority = params[:priority]

        @record.save

        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("records", @record)
            end
      
            format.html { redirect_to records_url(@domain) }
        end
    end

    def edit
        @record = Record.find(params["id"].to_i)
        
        if @record.nil?
            render status: 404, plain: "404 Not Found"
            return
        end

        if(@record.domain_id != Domain.find_by(host: params[:host])&.id)
            render status: 403, plain: "403 Forbidden"
        end 

        @domain = Domain.find_by(host: params['host'])

        render turbo_stream: turbo_stream.replace("record_#{@record.id}", partial: "edit", locals: { record: @record })

    end

    def show
        @record = Record.find(params["id"].to_i)
        if @record.nil?
            render status: 404, plain: "404 Not Found"
            return
        end
        if(@record.domain_id != Domain.find_by(host: params[:host])&.id)
            render status: 403, plain: "403 Forbidden"
        end

        @domain = Domain.find_by(host: params['host'])
    end
end
