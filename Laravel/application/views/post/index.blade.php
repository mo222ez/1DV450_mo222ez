@layout('template')

@section('title')
	Blogg
@endsection

@section('main_content')
	@forelse ($posts as $post)
		<div class="post">
			<h2>
				{{ HTML::link_to_route('view_post', $post->title, $post->id) }}
			</h2>
			<p>
				{{ substr($post->content, 0, 120).' [...]' }}
			</p>
			<p>
				{{ HTML::link_to_route('view_post', 'Read more &rarr;', $post->id) }}
			</p>
		</div>
	@empty
		<h2>
			No posts
		</h2>
	@endforelse
@endsection