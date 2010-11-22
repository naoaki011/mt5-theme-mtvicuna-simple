/*
どこでもはてブ - Hatena bookmark anywhere
http://blog.masuidrive.jp/index.php/category/hba/

The MIT License
Copyright (c) 2008 Yuichiro MASUI <masui@masuidrive.jp>
 */
var hatena_bookmark_anywhere_style; // falseを設定するとCSSでスタイルの指定が可能になる
var hatena_bookmark_anywhere_limit; // 表示件数
var hatena_bookmark_anywhere_collapse; // trueにすると、コメントの書いてないブクマを表示しない。指定しない場合は、表示件数を超えた場合のみ表示しない
var hatena_bookmark_anywhere_url; // 表示するURL 未指定の場合、このページ

function __hatena_bookmark_anywhere_receiver(json) {
	try {
		var html = "";

		var escapeHTML = function(str) {
			str = str.replace("&","&amp;");
			str = str.replace("\"","&quot;");
			str = str.replace("'","&#039;");
			str = str.replace("<","&lt;");
			str = str.replace(">","&gt;");
			return str;
		}

		// http://juce6ox.blogspot.com/2007/11/cssdom.html
		// by latchet
		var addCSSRule = (document.createStyleSheet)
			? (function(sheet){
				return function(selector, declaration){
					sheet.addRule(selector, declaration);
				};
			})(document.createStyleSheet())
			: (function(sheet){
				return function(selector, declaration){
					sheet.insertRule(selector + '{' + declaration + '}', sheet.cssRules.length);
				};
			})((function(e){
				e.appendChild(document.createTextNode(''));
				(document.getElementsByTagName('head')[0] || (function(h){
					document.documentElement.insertBefore(h, this.firstChild);
					return h;
				})(document.createElement('head'))).appendChild(e);
			    return e.sheet;
			})(document.createElement('style')))

		if(hatena_bookmark_anywhere_style!==false) {
			addCSSRule("#hatena_bookmark_anywhere", "font-size: 90%; font-family: \"Arial\", sans-serif; color: #000;");
			addCSSRule("#hatena_bookmark_anywhere * ", "margin: 0; padding: 0; text-align: left; font-weight: normal; font-family: \"Arial\", sans-serif;");
			addCSSRule("#hatena_bookmark_anywhere .hatena_bookmark_anywhere_zero", "background-color:#edf1fd; border-top:1px solid #5279e7; list-style-position: inside; margin:2px 0 0 0;padding: 8px 5px 12px 8px;");
			addCSSRule("#hatena_bookmark_anywhere ul", "background-color:#edf1fd; border-top:1px solid #5279e7; list-style-position: inside; margin:2px 0 0 0;padding: 8px 5px 12px 8px;");
			addCSSRule("#hatena_bookmark_anywhere ul li", "list-style-type: circle; padding: 1px 0;");
			addCSSRule("#hatena_bookmark_anywhere .hatena_bookmark_anywhere_user", "color: #00e; text-decoration: underline; margin: 0 2px;");
			addCSSRule("#hatena_bookmark_anywhere .hatena_bookmark_anywhere_tags", "font-size: 90%; color: #66c; margin: 0 4px 0 2px;");
			addCSSRule("#hatena_bookmark_anywhere .hatena_bookmark_anywhere_tags a", "text-decoration: none; color: #66c;");
			addCSSRule("#hatena_bookmark_anywhere .hatena_bookmark_anywhere_go", "font-size: 90%; color: #66c; text-decoration: none;");
		}

		if(json==null) {
			html += "このエントリーのはてなブックマーク数 (0) <a class=\"hatena_bookmark_anywhere_go\" href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\">はてなブックマークのページへ飛ぶ</a><br/>";
			html += "<div class=\"hatena_bookmark_anywhere_zero\">";
			html += "このページはまだブックマークされていません。";
			html += "</div>";
		}
		else {
			if((typeof hatena_bookmark_anywhere_limit)!="number") hatena_bookmark_anywhere_limit = 100;
			if((typeof hatena_bookmark_anywhere_collapse)=="undefined" && json.bookmarks.length>hatena_bookmark_anywhere_limit) hatena_bookmark_anywhere_collapse = true;

			for(var i=0; i<json.bookmarks.length&&hatena_bookmark_anywhere_limit>0; ++i) {
				var bookmark = json.bookmarks[i];
				var t = bookmark.timestamp.split(" ")[0].split("/");
				var tags = [];
				for(var j=0; j<json.bookmarks[i].tags.length; ++j) {
					var tag = json.bookmarks[i].tags[j];
					tags.push("<a href=\"http://b.hatena.ne.jp/"+bookmark.user+"/"+tag+"\">"+escapeHTML(tag)+"</a>");
				}
				if(hatena_bookmark_anywhere_collapse!=true || bookmark.comment!='') {
					html += "<li><span class=\"__hatena_bookmark_anywhere_timestamp\">"+escapeHTML(t[0])+"年"+escapeHTML(t[1])+"月"+escapeHTML(t[2])+"日</span><img src=\"http://www.hatena.ne.jp/users/"+escapeHTML(bookmark.user.substring(0,2))+"/"+bookmark.user+"/profile_s.gif\" width=\"16\" height=\"16\"><a href=\"http://b.hatena.ne.jp/"+escapeHTML(bookmark.user)+"/"+escapeHTML(t.join(""))+"\" class=\"hatena_bookmark_anywhere_user\">"+escapeHTML(bookmark.user)+"</a><span class=\"hatena_bookmark_anywhere_tags\">"+tags.join(", ")+"</span>"+escapeHTML(bookmark.comment)+"</li>";
					hatena_bookmark_anywhere_limit--;
				}
			}
			if ( html != "") {
				html = "<ul id=\"bookmarked_user\">"+html+"</ul>";
			} else {
				html += "<div class=\"hatena_bookmark_anywhere_zero\">まだ「はてなブックマーク」コメントが付いていません。</div>";
			}
			html = "このエントリーのはてなブックマーク数 ("+json.count+") <a class=\"hatena_bookmark_anywhere_go\" href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\">はてなブックマークのページへ飛ぶ</a>"+html;
		}

		var wrap = document.createElement("div");
		wrap.innerHTML = html;
		document.getElementById("hatena_bookmark_anywhere").appendChild(wrap);
    } catch(e) { }
}

function __hatena_bookmark_anywhere_loade() {
    try {
	if((typeof document.getElementById("hatena_bookmark_anywhere"))!="undefined") {
	    var script = document.createElement("script");
	    script.setAttribute("type","text/javascript");
	    if((typeof hatena_bookmark_anywhere_url)=="undefined") hatena_bookmark_anywhere_url = location.href.replace(/#.*/,"");
	    script.setAttribute("src","http://b.hatena.ne.jp/entry/json/?url="+hatena_bookmark_anywhere_url+"&callback=__hatena_bookmark_anywhere_receiver");
	    document.body.appendChild(script);
	}
    } catch(e) { }
}

try {
    if(window.addEventListener) {
	window.addEventListener("load", __hatena_bookmark_anywhere_loade, false);
    }
    else {
	window.attachEvent("onload", __hatena_bookmark_anywhere_loade);
    }
} catch(e) { }
