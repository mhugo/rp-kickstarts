# NOTE: Copy this post section in your project customisation if
# you want to install some binding at the first image boot up.
# Then, change 'helloworld-binding' with your binding.
%post
BINDING="\
	helloworld-binding \
        afb-mqtt-ext \
"
echo "BINDING=\"\$BINDING ${BINDING}\"" >> /tmp/binding-list
%end
