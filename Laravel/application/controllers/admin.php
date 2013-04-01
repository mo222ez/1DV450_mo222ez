<?php

class Admin_Controller extends Base_Controller {
	
	public function action_index()
	{
		//return Redirect::to_route('login');
		return view::make('admin.login');
	}

	public function action_login()
	{
		$userdata = array(
			'username' => Input::get('username'),
			'password' => Input::get('password')
		);

		if (Auth::attempt($userdata)) {
			return Redirect::to_route('new_post');
		}

		else {
			return Redirect::to_route('login')
				->with('login_errors', true);
		}
	}

	public function action_logout()
	{
		Auth::logout();
		return Redirect::to_route('home');
	}

	public function action_new()
	{
		$user = Auth::user();
		return view::make('admin.new')->with('user', $user);
	}

	public function action_create()
	{
		$new_post = array(
			'title' => Input::get('title'),
			'content' => Input::get('content'),
			'author_id' => Input::get('author_id')
		);

		$rules = array(
			'title' => 'required|min:3|max:128',
			'content' => 'required'
		);

		$v = Validator::make($new_post, $rules);

		if ($v->fails()) {
			return Redirect::to_route('new_post')
				->with('user', Auth::user())
				->with_errors($v)
				->with_input();
		}

		$post = new Post($new_post);
		$post->save();

		return Redirect::to('view/' . $post->id);
	}
}













?>