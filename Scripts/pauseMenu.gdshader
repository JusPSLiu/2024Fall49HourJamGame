shader_type canvas_item;

uniform sampler2D texturee : repeat_enable;
uniform sampler2D texture2 : repeat_enable;
uniform vec2 spdyness;
uniform vec2 spdyness2;
uniform vec2 spdyness3;
uniform vec4 actualColor;
uniform vec4 reddy = vec4(1,0,0,1);
uniform vec4 invercolor = vec4(.3,.3,.2,0);
uniform sampler2D faderTexture;

void fragment() {
	COLOR = (texture(faderTexture, UV)*(reddy + texture(texturee, UV+TIME*spdyness) * texture(texture2, UV+TIME*spdyness2)* texture(texture2, UV+TIME*spdyness3)- texture(texturee, (UV*vec2(.4,.4))+TIME*spdyness3)*invercolor)*actualColor);
}
