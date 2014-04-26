import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:intl/intl.dart';

void main() {
  js.context.tumblrCallback = (jsonData) {
    DivElement tumblr = document.querySelector("#tumblr");
    var posts = jsonData.response.posts;
    DateFormat formatter = new DateFormat('d MMM y');

    for (int i = 0; i < posts.length; i++) {
      AnchorElement title = new AnchorElement(href: posts[i].post_url);
      title.text = posts[i].title;
      tumblr.children.add(title);

      DateTime postDate = new DateTime.fromMillisecondsSinceEpoch(posts[i].timestamp * 1000, isUtc: true);
      DivElement date = new DivElement();
      date.text = formatter.format(postDate.toLocal());
      tumblr.children.add(date);

      DivElement post = new DivElement();
      post.appendHtml(posts[i].body);
      tumblr.children.add(post);
    };
  };

  // add a script tag for the api required
  ScriptElement script = new Element.tag("script");
  // add the callback function name to the URL
  String url = "https://api.tumblr.com/v2/blog/nerdrew.tumblr.com/posts";
  String apiKey = "VhbkyXMOVWi1OqQFUvjsXKckWcWhl8ztLV0LHY1TKbNc3zhGDc";
  String callback = "tumblrCallback";
  script.src = "$url?api_key=$apiKey&callback=$callback";
  document.body.children.add(script); // add the script to the DOM
}
