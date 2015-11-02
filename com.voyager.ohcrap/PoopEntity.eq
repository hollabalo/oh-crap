// OhCrap v. 1.0
// 2015 JM Gerona
// Voyager

public class PoopEntity : SEMovingSpriteEntity
{
	int x;
	int y;
	GameplayScene mains;
	
	public void initialize(SEResourceCache rsc) {
		base.initialize(rsc);
		set_image(SEImage.for_resource("poop"));
		x = Math.random(get_width()/2, get_scene_width() - get_width()/2);
		y = get_height()/2;
		move(x, y);
		mains = get_scene() as GameplayScene;
	}

	public void tick(TimeVal now, double delta) {
		base.tick(now, delta);
		if(y + get_height()/4 > get_scene_height() - get_height()) {
			remove_entity();
		}
		else {
			y += get_height()/20;
			move(x, y);
			if(is_collide()) {
				mains.life_subtract();
			}
		}
	}

	public bool is_collide() {
		if(mains.get_person_x() + mains.get_person_width() > get_x() &&
		   		mains.get_person_x() + mains.get_person_width()/2 < get_x() &&
		   		mains.get_person_y() + mains.get_person_height()/2 > get_y() &&
		   		mains.get_person_y() - mains.get_person_height()/2 < get_y()) {
			remove_entity();
			base.cleanup();
			return(true);
		}
		return(false);
	}
}
