// OhCrap v. 1.0
// 2015 JM Gerona
// Voyager

public class MenuScene : SEScene
{
	SESprite background;
	SEResourceCache rs;
	SEButtonEntity btn_play;
	SEButtonEntity btn_exit;
	SESprite title;

	public void initialize(SEResourceCache rsc) {
		base.initialize(rsc);
		rs = rsc;
		bg();
		set_title();
		play_button();
		exit_button();
	}

	public void on_message(Object o) {
		if("Play".equals(o)) {
			clear_entities();
			pop_scene();
			switch_scene(new GameplayScene());
			return;
		}
		if("Exit".equals(o)) {
			base.cleanup();
			SystemEnvironment.terminate(0);
		}
	}

	public void play_button() {
		var x = get_scene_width()/4;
		var y = get_scene_height()/6;
		rs.prepare_image("btn_play", "btn_play", get_scene_width()*0.3, get_scene_height()*0.2);
		btn_play = SEButtonEntity.for_image(SEImage.for_resource("btn_play"))
								 .set_data("Play")
								 .set_listener(this);
		add_entity(btn_play);
		btn_play.move(get_scene_width()/2 - x/2, get_scene_height()/2 - y);
	}

	public void exit_button() {
		var x = get_scene_width()/4;
		var y = get_scene_height()/6;
		rs.prepare_image("btn_exit", "btn_exit", get_scene_width()*0.3, get_scene_height()*0.2);
		btn_exit = SEButtonEntity.for_image(SEImage.for_resource("btn_exit"))
			.set_data("Exit")
			.set_listener(this);
		add_entity(btn_exit);
		btn_exit.move(get_scene_width()/2 - x/2, get_scene_height()/2);
	}

	public void set_title() {
		rs.prepare_font("white", "arialblack color=white", get_scene_width()*0.1);
		title = add_sprite_for_text("Oh CRAP!", "white");
		title.move(get_scene_width()/2 - get_scene_width()*0.2, get_scene_height()/2 - get_scene_height()*0.4);
	}

	public void bg() {
		rs.prepare_image("background", "bg", get_scene_width(), get_scene_height());
		background = add_sprite_for_image(SEImage.for_resource("background"));
		background.move(0, 0);
	}
}
