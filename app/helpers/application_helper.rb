module ApplicationHelper

	def title
		"Joblr | #{@title}"
	end

  # Analytics
  # ---------

  def mixpanel_init
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
      mixpanel.init('89fa09c4d2027533d28bcb52797527c3');".html_safe
    end
  end

  def mixpanel_call(action, value, properties = nil)
    content_tag(:script, type: 'text/javascript') {"mixpanel.#{action}('#{value}'#{', '+properties if properties});".html_safe} #if Rails.env.production? || Rails.env.test?
  end
end
