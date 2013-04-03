module ApplicationHelper

	def title
		"Joblr | #{@title}"
	end

  def default_locale
    %w(en fr).include?(I18n.locale.to_s) ? I18n.locale.to_s : 'en'
  end

  # Errors
  # ------

  def error_messages(object, options = {})
    errors = unduplicated_errors(object, options).map! do |attribute, message|
      "#{object.class.human_attribute_name(attribute).downcase} #{message}"
    end.to_sentence.humanize+'.'
  end

  def unduplicated_errors(object, options = {})
    object.errors.select do |attribute, message|
      options[:only] ? options[:only].include?(attribute) && message == object.errors[attribute].first : message == object.errors[attribute].first
    end
  end

  # Analytics
  # ---------

  def analytics_init
    if request.subdomain.present? && request.subdomain.match(/^join|resume$/)
      ga_init(4)
    elsif request.subdomain.present? && request.subdomain.match(/^signup$/)
      ga_init(5)
    end
  end

  def ga_init(id)
    content_tag(:script, type: 'text/javascript') do
      "var _gaq = _gaq || [];
       _gaq.push(['_setAccount', 'UA-34334309-#{id}']);
       _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
      ".html_safe
    end
  end

  def mixpanel_init(environment)
    content_tag(:script, type: 'text/javascript') do
      "(function(e,b){
        if(!b.__SV){
          var a,f,i,g;
          window.mixpanel=b;a=e.createElement('script');
          a.type='text/javascript';
          a.async=!0;
          a.src=('https:'===e.location.protocol?'https:':'http:')+'//cdn.mxpnl.com/libs/mixpanel-2.2.min.js';
          f=e.getElementsByTagName('script')[0];
          f.parentNode.insertBefore(a,f);
          b._i=[];
          b.init=function(a,e,d){
            function f(b,h){
              var a=h.split('.');
              2==a.length&&(b=b[a[0]],h=a[1]);
              b[h]=function(){
                b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}
          var c=b;
          'undefined'!==typeof d?c=b[d]=[]:d='mixpanel';
          c.people=c.people||[];
          c.toString=function(b){
            var a='mixpanel';
            'mixpanel'!==d&&(a+='.'+d);
            b||(a+=' (stub)');
            return a};
          c.people.toString=function(){return c.toString(1)+'.people (stub)'};
          i='disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.increment people.append people.track_charge'.split(' ');
          for(g=0;g<i.length;g++)f(c,i[g]);
          b._i.push([a,e,d])};
          b.__SV=1.2}})
      (document,window.mixpanel||[]);
      mixpanel.init('#{mixpanel_key(environment)}');".html_safe
    end
  end

  def mixpanel_key(environment)
    case environment
      when :production
        '89fa09c4d2027533d28bcb52797527c3'
      when :staging
        '345b543f3ebc8d22839504a4d42de496'
    end
  end

  def mixpanel_call(action, value, properties = nil)
    content_tag(:script, type: 'text/javascript') {"mixpanel.#{action}('#{value}'#{', '+properties if properties});".html_safe}
  end

  def select_view_event
    if request.fullpath.include?('templates')
      mixpanel_call 'track', 'Clicked template CTA'
    elsif request.subdomain.match(/^join|staging$/) && !request.fullpath.include?('templates')
      mixpanel_call 'track', 'Viewed templates teaser page'
    elsif request.subdomain.match(/^resume$/) && !request.fullpath.include?('templates')
      mixpanel_call('track', 'Viewed templates teaser page', "{'price' : #{@price}}")
    else
      mixpanel_call 'track', 'Viewed feedback teaser page'
    end
  end
end
