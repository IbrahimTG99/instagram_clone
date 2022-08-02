def typeahead
  render json: Model.where('name ilike ?', "%#{params[:query]}%")
end
