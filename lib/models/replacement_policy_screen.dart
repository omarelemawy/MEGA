import 'category_model.dart';

class ReplacementPolicyScreenModel {
  int? id;
  String? date;
  String? dateGmt;
  Guid? guid;
  String? modified;
  String? modifiedGmt;
  String? slug;
  String? status;
  String? type;
  String? link;
  Guid? title;
  Content? content;
  Content? excerpt;
  int? author;
  int? featuredMedia;
  int? parent;
  int? menuOrder;
  String? commentStatus;
  String? pingStatus;
  String? template;
  Meta? meta;
  Links? lLinks;

  ReplacementPolicyScreenModel(
      {this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.content,
        this.excerpt,
        this.author,
        this.featuredMedia,
        this.parent,
        this.menuOrder,
        this.commentStatus,
        this.pingStatus,
        this.template,
        this.meta,
        this.lLinks});

  ReplacementPolicyScreenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    excerpt =
    json['excerpt'] != null ? new Content.fromJson(json['excerpt']) : null;
    author = json['author'];
    featuredMedia = json['featured_media'];
    parent = json['parent'];
    menuOrder = json['menu_order'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    template = json['template'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid!.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt!.toJson();
    }
    data['author'] = this.author;
    data['featured_media'] = this.featuredMedia;
    data['parent'] = this.parent;
    data['menu_order'] = this.menuOrder;
    data['comment_status'] = this.commentStatus;
    data['ping_status'] = this.pingStatus;
    data['template'] = this.template;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Meta {
  String? siteSidebarLayout;
  String? siteContentLayout;
  String? astGlobalHeaderDisplay;
  String? astMainHeaderDisplay;
  String? astHfbAboveHeaderDisplay;
  String? astHfbBelowHeaderDisplay;
  String? astHfbMobileHeaderDisplay;
  String? sitePostTitle;
  String? astBreadcrumbsContent;
  String? astFeaturedImg;
  String? footerSmlLayout;
  String? themeTransparentHeaderMeta;
  String? advHeaderIdMeta;
  String? stickHeaderMeta;
  String? headerAboveStickMeta;
  String? headerMainStickMeta;
  String? headerBelowStickMeta;

  Meta(
      {this.siteSidebarLayout,
        this.siteContentLayout,
        this.astGlobalHeaderDisplay,
        this.astMainHeaderDisplay,
        this.astHfbAboveHeaderDisplay,
        this.astHfbBelowHeaderDisplay,
        this.astHfbMobileHeaderDisplay,
        this.sitePostTitle,
        this.astBreadcrumbsContent,
        this.astFeaturedImg,
        this.footerSmlLayout,
        this.themeTransparentHeaderMeta,
        this.advHeaderIdMeta,
        this.stickHeaderMeta,
        this.headerAboveStickMeta,
        this.headerMainStickMeta,
        this.headerBelowStickMeta});

  Meta.fromJson(Map<String, dynamic> json) {
    siteSidebarLayout = json['site-sidebar-layout'];
    siteContentLayout = json['site-content-layout'];
    astGlobalHeaderDisplay = json['ast-global-header-display'];
    astMainHeaderDisplay = json['ast-main-header-display'];
    astHfbAboveHeaderDisplay = json['ast-hfb-above-header-display'];
    astHfbBelowHeaderDisplay = json['ast-hfb-below-header-display'];
    astHfbMobileHeaderDisplay = json['ast-hfb-mobile-header-display'];
    sitePostTitle = json['site-post-title'];
    astBreadcrumbsContent = json['ast-breadcrumbs-content'];
    astFeaturedImg = json['ast-featured-img'];
    footerSmlLayout = json['footer-sml-layout'];
    themeTransparentHeaderMeta = json['theme-transparent-header-meta'];
    advHeaderIdMeta = json['adv-header-id-meta'];
    stickHeaderMeta = json['stick-header-meta'];
    headerAboveStickMeta = json['header-above-stick-meta'];
    headerMainStickMeta = json['header-main-stick-meta'];
    headerBelowStickMeta = json['header-below-stick-meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site-sidebar-layout'] = this.siteSidebarLayout;
    data['site-content-layout'] = this.siteContentLayout;
    data['ast-global-header-display'] = this.astGlobalHeaderDisplay;
    data['ast-main-header-display'] = this.astMainHeaderDisplay;
    data['ast-hfb-above-header-display'] = this.astHfbAboveHeaderDisplay;
    data['ast-hfb-below-header-display'] = this.astHfbBelowHeaderDisplay;
    data['ast-hfb-mobile-header-display'] = this.astHfbMobileHeaderDisplay;
    data['site-post-title'] = this.sitePostTitle;
    data['ast-breadcrumbs-content'] = this.astBreadcrumbsContent;
    data['ast-featured-img'] = this.astFeaturedImg;
    data['footer-sml-layout'] = this.footerSmlLayout;
    data['theme-transparent-header-meta'] = this.themeTransparentHeaderMeta;
    data['adv-header-id-meta'] = this.advHeaderIdMeta;
    data['stick-header-meta'] = this.stickHeaderMeta;
    data['header-above-stick-meta'] = this.headerAboveStickMeta;
    data['header-main-stick-meta'] = this.headerMainStickMeta;
    data['header-below-stick-meta'] = this.headerBelowStickMeta;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<Collection>? collection;
  List<Self>? about;
  List<Author>? author;
  List<Author>? replies;
  List<VersionHistory>? versionHistory;
  List<Self>? wpAttachment;
  List<Curies>? curies;

  Links(
      {this.self,
        this.collection,
        this.about,
        this.author,
        this.replies,
        this.versionHistory,
        this.wpAttachment,
        this.curies});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <Collection>[];
      json['collection'].forEach((v) {
        collection!.add(new Collection.fromJson(v));
      });
    }
    if (json['about'] != null) {
      about = <Self>[];
      json['about'].forEach((v) {
        about!.add(new Self.fromJson(v));
      });
    }
    if (json['author'] != null) {
      author = <Author>[];
      json['author'].forEach((v) {
        author!.add(new Author.fromJson(v));
      });
    }
    if (json['replies'] != null) {
      replies = <Author>[];
      json['replies'].forEach((v) {
        replies!.add(new Author.fromJson(v));
      });
    }
    if (json['version-history'] != null) {
      versionHistory = <VersionHistory>[];
      json['version-history'].forEach((v) {
        versionHistory!.add(new VersionHistory.fromJson(v));
      });
    }
    if (json['wp:attachment'] != null) {
      wpAttachment = <Self>[];
      json['wp:attachment'].forEach((v) {
        wpAttachment!.add(Self.fromJson(v));
      });
    }
    if (json['curies'] != null) {
      curies = <Curies>[];
      json['curies'].forEach((v) {
        curies!.add(new Curies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.about != null) {
      data['about'] = this.about!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.map((v) => v.toJson()).toList();
    }
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    if (this.versionHistory != null) {
      data['version-history'] =
          this.versionHistory!.map((v) => v.toJson()).toList();
    }
    if (this.wpAttachment != null) {
      data['wp:attachment'] =
          this.wpAttachment!.map((v) => v.toJson()).toList();
    }
    if (this.curies != null) {
      data['curies'] = this.curies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Author {
  bool? embeddable;
  String? href;

  Author({this.embeddable, this.href});

  Author.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class VersionHistory {
  int? count;
  String? href;

  VersionHistory({this.count, this.href});

  VersionHistory.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['href'] = this.href;
    return data;
  }
}

class Curies {
  String? name;
  String? href;
  bool? templated;

  Curies({this.name, this.href, this.templated});

  Curies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    href = json['href'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['href'] = this.href;
    data['templated'] = this.templated;
    return data;
  }
}
