---
date: 2016-03-22T22:34:50-07:00
title: "Django Search: Multiple Fields and Full Text"
url: django-search-multiple-fields
tags: [ software,django,data ]
---

## Text Search - Django Model Fields

Django has a pretty flexible ORM, but sometimes clients need a free-form text search to get down to the content that you are looking for. It is beyond the capability of most engineers to build a comprehensive search tool and shoehorn it into an existing application. There are people working on these problems for years.

This does remind me of a senior boss that asked me to add a fuzzy search field to an application and that it was "super simple". He said "you just do a LIKE statement against all the fields we care about!" and proceeded to pseudo code it for me. He should read my post about how not to F'k up your engineering staff.

### Searching with Like Statements

This is probably the first place an inexperienced engineer will start. Just pick the field and do a LIKE statement against it.

ex:

```python
User.objects.filter(username__icontains=keyword)
```

Which will result in:
`SELECT * FROM ... WHERE USERNAME LIKE `

This doesn't scale. It's amateurish.

But this will satisfy an annoying manager for the time being considering they probably know little about computer science.

### Using Q Objects

The [Q object](https://docs.djangoproject.com/en/dev/topics/db/queries/#complex-lookups-with-q-objects) in Django is kinda nice. It wraps the queryset. I need a little more information on it to be able to speak intelligently. But that aside I decided to use it in a few places where dynamic queries were valuable.

After doing a little looking I found this response on [stack overflow](http://stackoverflow.com/questions/26634874/how-can-i-make-django-search-in-multiple-fields-using-querysets-and-mysql-full) where they suggested using this. I can tell immediately that it's not very scalable under big load.  At the least I can get it going now with only minor levels of sin.

That post is apparently taken from [Julien Phalip - adding search to django in a snap.](http://julienphalip.com/post/2825034077/adding-search-to-a-django-site-in-a-snap). So credit is given. Nice work.

```python
def normalize_query(query_string,
    findterms=re.compile(r'"([^"]+)"|(\S+)').findall,
    normspace=re.compile(r'\s{2,}').sub):

    '''
    Splits the query string in invidual keywords, getting rid of unecessary spaces and grouping quoted words together.
    Example:
    >>> normalize_query('  some random  words "with   quotes  " and   spaces')
        ['some', 'random', 'words', 'with quotes', 'and', 'spaces']
    '''

    return [normspace('',(t[0] or t[1]).strip()) for t in findterms(query_string)]

def get_query(query_string, search_fields):

    '''
    Returns a query, that is a combination of Q objects.
    That combination aims to search keywords within a model by testing the given search fields.
    '''

    query = None ## Query to search for every search term
    terms = normalize_query(query_string)
    for term in terms:
        or_query = None ## Query to search for a given term in each field
        for field_name in search_fields:
            q = Q(**{"%s__icontains" % field_name: term})
            if or_query is None:
                or_query = q
            else:
                or_query = or_query | q
        if query is None:
            query = or_query
        else:
            query = query & or_query

def search_for_something(request):
   query_string = ''
   found_entries = None
   if ('q' in request.GET) and request.GET['q'].strip():
       query_string = request.GET['q']
       entry_query = get_query(query_string, ['field1', 'field2', 'field3'])
       found_entries = Model.objects.filter(entry_query).order_by('-something')

   return render_to_response('app/template-result.html',
           { 'query_string': query_string, 'found_entries': found_entries },
           context_instance=RequestContext(request)
       )
```

Another helpful resource was from [Yeti](https://yeti.co/blog/global-search-in-django-rest-framework/) adding in some global search. A bit outdated but a nice resource.



### Search Library



https://github.com/django-haystack/django-haystack

https://github.com/etianen/django-watson
