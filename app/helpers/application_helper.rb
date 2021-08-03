module ApplicationHelper
  def turbo_frame_tag(id, src: nil, target: nil, **attributes, &block)
    id = id.respond_to?(:to_key) ? dom_id(id) : id
    src = url_for(src) if src.present?

    tag.turbo_frame(**attributes.merge(id: id, src: src, target: target).compact, &block)
  end

  def broadcast_append_to(*streamables, target: broadcast_target_default, **rendering)
    Turbo::StreamsChannel.broadcast_append_to *streamables, target: target, **broadcast_rendering_with_defaults(rendering)
  end

  
  
end



