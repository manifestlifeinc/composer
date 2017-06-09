ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -e

# Docker stop function
function stop()
{
P1=$(docker ps -q)
if [ "${P1}" != "" ]; then
  echo "Killing all running containers"  &2> /dev/null
  docker kill ${P1}
fi

P2=$(docker ps -aq)
if [ "${P2}" != "" ]; then
  echo "Removing all containers"  &2> /dev/null
  docker rm ${P2} -f
fi
}

if [ "$1" == "stop" ]; then
 echo "Stopping all Docker containers" >&2
 stop
 exit 0
fi

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# stop all the docker containers
stop


# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh
./fabric-dev-servers/createComposerProfile.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground-unstable.yml up -d

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

echo
echo "--------------------------------------------------------------------------------------"
echo "Hyperledger Fabric and Hyperledger Composer installed, and Composer Playground launched"
echo "Please use 'composer.sh' to re-start"

# removing instalation image
rm "${DIR}"/install-hlfv1-unstable.sh

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �:Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[�/�$!�:���Q����u|���`�_>H�&�W�&���;|Aq�H���� (��ė�9�y�M���Z��:�����r���C�>���i7���`���2��q��)��+���������@�X�Bx%�2�f�_�S\.���J�e�B�߽�W쭣�r�h5���/���u������O!(Rɿ\���:�2�L��O��Q�A����P�أ���(IS_j�Oj�#��?����ʽ������]��]�<�l�%l��i��X�$l�sY��|�t|ԧ)��\��(�EQ�'����^������?E���q}������G��?\�_��Y������.��km�:�AJ��&���ĻlR_�L~o�Q�k�VCٴ��MfBj��|����F_!X�b3h�q<u��ؤ������D�)�F=D!���t��S�N'[	��n C�T��>am�}yq �HqՏl���_�k߾A�Ɗ���c�������Eӥ��;���0�Z�+%�������ď���_�z�S�O���/�?/�,�|�6o5�,�M���A.s �5e)�ɬ�m�!ǳ�Rܶ���\�&�Y��i�q��e9�k�`jZC�[�� Jq#�D�S�&e�p�u#2�q�p�)��)� �6�8�C֐��#u�D]���Ev����A܉�q�jr@1�&��Z=7rw
G� �qEPr�x=X�b�#���4y���rK;
��[0Qx�Tv��й������i,"om졸�f`p�s�,�\Í���-�ܷ
�@��Y����_1��㡹7��R1���)n�M�'
�No

�8�WňP�<�9���n$�)a7�a/�-��bc���9}���)�h'�rVr�P����]i�Y&n��Vw�t3עf��)�8>�'�"�xy2�S4�E������5���'�K
P80y�(r�r�,��t�1)m�&Fv��Ê	��R=0�6H�\�h�D�i��&C!J !P�/k<y:9�����	t	#.b�fu0���n����ڹr�Iڒ�hj�x1��C&K f�ȱh�sfы��(�e��F��=3��/��l������(Q�)� �?Jj����S��P
��������'����G�y��S��]��H��9Zr;ˇr$��B?b�K����P�I9�S�bqU0U��"��~�Wf�}�"�;� Z�XX���+9$�MY���q��h1Qt+��)�)�a�P_�&N�&.�n��s����2�M���4���j�vZ�b�w� 4��[�.u��z��3w�V�J�Bx��К0
�-�G�H�-MSΌ�5 �$./�@���y����*�q���1�����8�t�܇�.��w|K3ymJ
�(�Hs?4���\rآQ��R�l�9��L�k|'p$�,���&��/�D�0����t��<�1>�@��亖L��)�fV}ȡ�a��?�����k������$IU���C��3���{��Fъ��@��W�������/��7�^��J`���_��'�� ��W
���*����?�St��(Fxe���	p�d�_�!h��Ew�e
���E� �h��H�����P��_��~�CQH������vO��M
Zy8�XOP�Yǳ�>Wx�qpa��Q��Ë�?k�؂m�
f�dܐ����[&_z˖2�'�!rXm|�1�>��:ݎ,h��ܘ��%���_�[P�	v��lO�*��������?U�)�(�x�Y��2P��U���_���.����?������������R����=��f�GB��
Sz��Ђ���?�}0���C�f	����>�.to;M�w��q���G&]���dR�M��5�{&h�����Ρ"�1�+�0�C����ٰ�L�[��(�cД(�𸘠KnP�dՎ�cx�h]c��-���1"�H������ N4�Y8e�!9H϶�"�0y�J�^;w�	�)��P�&+����Q^p�ߙ�8>Z���ɠ	U��"�}�c�+~>4��~-&!oם�6;���gJ�Һ���r�c�����N�H�G2g)���:��9O�
�$+��V<�?�/��ό��*�/"�ψ����T���W���k�Y����� ���Q���\"�Wh�E\���������+��������!����$��*.U�_	���=�&�p�Q��Ѐ�	�`h׷4�0�u=7pqa�#��H��>��,IRv�����_���^�e���?�	�"�Z�T��csbkL�6��s�U�����Г��b�J }'��N�VRjhH�(�Nb{��W#�D�Q�[��nno��P�' �!H�g�A+z�d�~8�����fU�߻�x�ǩ�~���?J��9x���'���w��P�����B�߾�L)\.�D��_
�+���/_V�˟�	���H����b���qK`%��;��`8�|�']����O��,�Ѕ��bD�b�cۤ��K�.F!�K�,f{X�������L8��2��VE���_���#�������?]D��� �D4L^L�ݠ�nci�x�s�X鮑&����V�p�e���+�au]��S��0"7�3�`��(�|�G�|F�T��Nc�[����&���k��3[��ލ���/m}��GЕ�W
~�%�������W>i�?Ⱦ4Z�B�(C���(A>��&����R�Z�W���������]���X��a���ǳ�>�Y@���g�ݏ��{P����]P�z�F��=tw��ρnX�΁���~�9�Ѓ��6��2q�p��N�}1/�.���G��&1]���&�����k��4�Gx,�3��gr�CMf=Q'���7G����Q[x+.�K����Dӭ3�YO>�#ܖ�Q�2��8��n�u_;ms.���k ��ݚ�r.k)ZV�y:E��ڔ�9��t��nw�cC��B�w{�C ����䶷�<����à�bM p"�r65�y{WW\����Vd���Fg9�,3�V�֟��A��߃ j�;%6�NГr�&{+~f��ni���p�5��!��x����/m�����_
~���+��o�����Vn�o�2�����l�'������m�?���?�m�a��o��N2;M�p�g�?���qo(�g���@y�@wA޺d�d����5`�5M|��?�O΃���ɡ���-*�;��5Y/��Z�o�JOM���C|k�r�Z��0�SٌI2��u��(�Z"��r��դ��y��!�~��܇.���� ��Y>h��@�Dk�<�w�u7��+e0��j.uq�?%s9��V{f��!Wk����=h�t�0B��G�P��a�?������/q��_���J�oa����?��?%�3�����A������?+���Q��W�������F���S`.��1����\.�˭�������,�W�_��������E=_�����\���G�4�a(�R�C�,�2��`���h��.��>J8d��T��>B�.�8�W���V(C���?:��B���Rp����Lɖ�þeN�6;}�!Bs�m�me�E��#mѢ&/��1ќ��J;�����(���)�G�  �mow���c�o]�5�Oaz���z8#P�249�P�7�+u�Ŧ=4����^������Qg��>Z|�=~>�Q!�'�(�U�l�4+����_�_���v���W�Vsm�x�զ��_k�}�����N:u�\�뎡n(�
�F��+{�L��g��v����_�ϕ�jW5	p������U�o��v��zul���>���:�^ǿh�$����V��^z_k٤v���zZG�(�u��H�>�VӅ_{��O�C���q�h��/��NΫ]9������I�W��;u�6^l"�A]×�����Oq��˵=]���Ҏ�Q��7w�AE�[[�v�<-|��ʰ�-v���ꂨ��MCTEtn:r�U ���C�O?/�>^�r_�fW�v��kE%��|��^�q������\;�BϾ��.:J�'ߺ�o^--���DYrg��X����}�u��Y�E���K�2iA���^ܛ������Ӻ8�?��n���6��5x���ߟWe���?��ǒ߿���4����NM��t>]�7�4�Z��d�qb�'p��p8]O6�u��~0�I�^�=L|�	�!�#%pVϧ�� }T�#����Gdq�S7�X=��^��2)���7|�*��q$�C4dE��o��y\VGƷu��'�J1g�^WV�o��t���I��᭝��f	�-����D�?{�㸑ݮ��k�v�F��dmӚ�|��H��3;S�i5�oI��d��(�E�I�;��� {� 	�=�e� ɞ��!9%� �%�S�l	� �E� �M�H��������:tS�z�^���ի��3�@���=���'Xl2�5L��Gn�MY�1i"�@�m0��"):]l�Y#�l6�z��Dj�2:FF�lI(���� /�L�>�Ywb��iڢG�0R�YC4���2���܆�YQ��&X�\����WIRz�8������h8_�J�+a���F&*�]
T �������0u]okP6�4j��H"�c9�N+3D�P2���&�9S��.�
�L���s�*A}T�\G��i���.#��5�f�BephB"�-!1-R���P�l���w������W(-����Qڂ\�Aݮ��EY֔XnM�/�5]dC>��t�A�4��Y���Ls�1�g3��9s��e0��������F-�����L���N[�5U�ȕEܾ�w�]wП��;I���yε���_�2�L��$2��(����Ll?��Rx�锪����3a�)ss_�7��~��,DE�xUl#0:f6��]����!�Ur����T�����1�%�m�ܭW��cP�����
���D���5$�]�)L���G�냙o�����Q%DvMm����a4�s,��d���9B��Ö4
mF?栠v�B���!x�`:���.4bos`�2��Ҫp�4�0s0Q��a��Q�B�^��ZȯEE��.�lt��mG���T�*T *����<D�YQD�r�`����ԛ�Y������j�#Cߡ,=�9�����?An�����l��p�Dj?h��l|��3�6>���l>�5T7L�56���U椑���o���Y[��&Y���е&{��}?���?H7:�p�������.pjE�ɴ$��(l�\8���,m��Qf�S�������?����,����iu ��:ū��p���xS�$��+�*���`IՎ,���8�
�L�;iߺ�"�]�e0���b�;�?NO���p�x)C�+�uw�!>T6���q���>��;��������(TE���F�Mb'�bϠJ�Я�Vm�F��N�}����Lr��5h�	��c&���Ԙhi��Ӽ[M���$�ED��faE5*n��T �&薬�x����Er�z���T���)Rdi`0e��8� |r�"}EKR��P��*��ť;�ndB�W�8��Q&He�{��$p��k��x�.�u\1\|�>� �v�!���`�స.�1����qXd\�Q�Y<����]H�9�B(�0��2�ඡRwq��
\���1�f�d���iN苺�^�8TY��:8�tbZ��#!2�����V��.�4�?��#�h��w�����d��)�������_ET�h�/�<�&3A��0���qo�*����0��Sܘ�_��@�G=�S����{������/w:a��L�߽�_H����;-��9U��U�O�Y���6����?��6&��pMn�p�KZ��
U�����8`�6�曍�9Z���*p�0��YS�����Iµ�_L���_�@��m��p���M�f�����J�IH�
��F��̙sy^UT4�#�N�U�`����+�4UE%@�!��Y=�\4�}�fb�ܽoC�$X�\�o[�:kf�����On"�����!~��u�@��dc��v��x�̚��E�Ț��s��i!�R-�G������\@0�R,+���o^���E3���fst&���U���)�E���&�ƪh��0���1��T���_���{�}�X�	|� ������U���#���������s��i�Ձ߿A�5��pc��Ɋ��2t
�b��%Z&�i��☖"Ǘ�[`�g�u~�_��sy=��?�V��a��%���Q���Al�����n��gRxU����O�?��l����4���A��"�>X�t\PUE� o�"���Q�Sm�xG�����g�a��zG7��H�&��Zb���e���Z��v���r�m�_��<�s�p4c���;XW��3)�J�}���c������>S�?�ڧ:�@���K�.,^u�F�檿]0Z�r��ċ��t�*/��3�;���U�_���\�����y&�W��7��ܮ����>�����G�)�L���-�m��~A�n�����BDN,O��C��R����w�*�箽r�+q�mmK4u˄6��v�9�G���:������yI��䄬���}RxU�����I���^H�����U������g��i�#Wa�{�h��g}]1�܁`�l,�W�&#5�Wd{OrgT��@��:1�oI��0�q��f$|q��	�$Ah/�
�ӼfÙ[kQ�[Pm/J����<RhhN�;
>����ko�El]~@����5��h!G� j%-�s�<Fl����@����F�$��&�ˮ�X�)≕�k�~w׹��Y�5׵��^����������."���'wM���^v�I���w�>Ϧ���~v ����^������_��x�n��?,U��r��{L{�G�=����Q����j����j�����
��}��)ft�G��ao|S���^���v}��j��{�7��~�����Ͽ��,>��1ҫ?�c� /Zac���� ��bc���?}|=~�6�oc?x{��?��R� ��h^jփ�ks��ws�z��\�����E�|���=�뱹f/�`z�]m�]�.L�OB��-`�@������0��1������q�	۫����
4��퐳�$c�Y���h���$�+D��rf��z�U ��%�w��{3|?_wA�a���0O���|#0�g��1g/c�#t�W�N�j��˾����f�{����ت3���5��asl�o륏� G���v��Z1W�f��`,lk�l&7跳��T��
'���[l��x��y��+0,��r-VK��6֜���ݬ8��C�WSmg��i��tȩ�t���K���67�mn�[�&<�+-l9�,l�D��K�G6�G�F{�SZW(����7!����i,�~5�;�<'F3b;!� �{��� ��MJe=�W.�������M��a>L�t����X�ّ�p=˄sM��'�0 ���Y�pz�Ig�L)�L�� H��H���n!ᜳ�3�S��as���D������/�!©��Uj��X,D¾�7�����E��l���+�f_p�|5�Jl9qP*)�M�d#������
�%�������� \���ǼW�p�#MޙI�5"_���/��Q&��e����P��Sr��uW����a�=��V9~:a���׊R<�2�T�Y����tV�Rs�2<�TX���y�}*���ZW��r�S�5����D�J����:M�2V����h�����OFDq�J��B5Izc�z����t��
Kl���K�dai�!,Q*��q�ޯ�y*&}�%��A%�d��j��r��q��A���P��ݎ���C=1����A�?�H��IM*�y:aa�IQ�"��R�J
Hz"�+�-�ibNXf��`�
K:����~��ϩb���5'���^�'6�\�v��%H���]w�����{�ɾ�Ry=(��B�=�Gr�:W���N;��I����l�m㳭�]�D���4^,��.�v{��W���e�����\}���P�����>�C�oN���^�̳��ITm%8��8����)������^ =��f��^1���OE��:�x��y��Ӓd���x=h�2����1��a�'P��oY�h�A[���K�yM��^2�ɊC���e���G?&���#ܮ��f��+�������l������s�X1(Ǿ���_��c�<�m6��bfԊ���~|\��m��'7��b(�b�����J@ ��+*:<_�� �����|�gb�w|6C���y����-�?���m�A�ڃ��Wv�Q�u��Qםf�p���V��B �����{?7����mjlZ끠��E��~�p��X�IT0���dX�
%ؕy�G9���f7�g�d�cJpT�4�b�Q��`����o}&gv���`4 ��y�]�C�!�$�?<r�y������wP@��E�8��1�h����1IքB0�zoոL)DBH0-7:;��������E��'�u��)�k��o��h���~����Z"P�� ��Gy*��d�Mj���Q*,�6D9d���v�N<�f!�Ct$Pˠg�j���Y��{��cL,!J�_�N0Jz��᱿�jȉ��M���t3�I��ތ����t�ʁ�=��m����&d��w��;�7����6�:{B?ދ�r]��	5OPP�~���:�������~IԊ�LLp����rl�c�+�X��Kz�U�T~c¹���!�1��1���A؞�M�-��D���+v���;�ȕ�����gj���a��am"i_�Hں�Hv"8�5��J�(5i�O������Y�wSVy��*7h����"��8kPdD0�"�dMhV�?����X����V;ᯧ���P8 �d�&�zJ�UٵG���v�rR�|���k��͐'�ZQ�Cf0�{���QJ"�-LCfc!���q,$X��N��vy-"rG-A���yg���݇Dԕ(tu��}�1�ر،��W,�u2R�����GJU褠
�a��̥D�����i؉��}��/��P�'�%�y��6�R��0��t��Kl�k�S�6ʱQ�/�r���!�#~k9e䩝��k���
ɭf���4�v!N碜����j��;�-��0�:�eE4�JE4M� �^/O-��o�-�PZ�)�
��a���l�&=ާ\�+���QI�=�Ǟþb��;�^�������ڗ��_#؟�������[���ǿ���&�d�`���Y�wۤ�t���zOQԚ�k���^�d+�R�����Y�y!	8��?��?��C���_����M�+�����o��޵���eeZbpefG50	uQ_����U��I��y'U�V��3�8��8��e��)�-$$�����z�%&H=c��W%��#uOپ���NUj{��ُo����k��U���?��7?�}������~��|�ſ�lE+8u�
'��?�އ�O�/~�'�����o������_�������_�?�g���v��Ň_�v�0������	 3`�	vq㾋���40������l@f��i����!ڃ~}�Q�K�@i��|��phZT�����O�no����m��3�n��ÿ=0���|�՞i�/? ; �;��
�R��`pDfg�
�WX�a̰�~�w��1I������8 ��33`p���W��}��0N�|�����XZ{�����~Fc��e_���/��X��=ζ�<���lO��H�k��)���1��	A�w��U�+�+
�@W3�+(���j�oX���Q1V��F��m����W�x��N�y�.[��OGΡwO�t�Ս�;l��>	����쫄�	�2��kg܉�~�e`���?vK��k?�p0S����˱1\?�o,�{��(��k������A�Ck�b���ᬦk����(���������,IRʝ��D+�^�~���g�A̬�th���%�ً�k=�ʨ�\m9��k
|��o���M ������K�bG�檓��W��VO�?y�o���X�w�(V��]A���"'U�V��\��=�;�]�j�Xϖ�OA�>�5-N���{�V�l��
�x#	��7N����?z��3�7�>��z�v��M� ��UYE.}"g�*5}Q2/��Ksζ4��y�Y{���ێ�'�V-��<W������F�7�#6�t��O���~^ճ�/���]�*[cn[c������m_T��AD�����v�����	ip%�"�5�m=�v��"	�>�~>H�|DO��#�bW�|�V�����7=J|�*��YN*�%A�oD�Q�!�@9�[o�|9�8Ln����%�X�4u�W0w,ǅg����F0�t���β��[h���K�cK����zL��w�+u�D&?�/�R��ճ��!x�ĭ�R�&��J�LA�����{lIuݒ~D�_�b��vU��M��a���Np0@��=q��޽��g�p�	��|�
	aZ����?�uW���I���h�n�G7��a�`�� ����p�I(�*ˊ�vy:�;v����F�r�%������f�x��%>��l�V_�!,ԯKռ쏜O[�N7Le:p�'���*(�(�����|�����q̄�a������1n܍ګ�A����	a�~���`�� Ϫ�#ݹ�%�ݗ�IQ6EgS��7���ز�c��O��k��ћ �:}�RGt����^t�MX�iQ/̄������Ee��� 1�
߳����2�n�0
��������2�o�F1��a���==e����O����%|	�i����3n\^����U[?���$}����o�>ض�mY�S�����[��C�<�o�a��+��F��a �O#�������X8�e`"� �����1?�����i��0�L�u�R(�PP��Q�bU�Pp]c�2R5P��H�U�HE�0��a��������1����`�Ԕ�5.�1�K�����TV㹊(Jb͝Nr�$X��/Z����+欂�vn@7�0ӦF�����(8�c5*B�͉�]�5�Om���m��.l��ȺN����n��u�3K#�z{ސ����њ%k�`I&%�J��PIS��a�ʧ��/�|��+:������������?�;��L�s���� ���{���c��G�4��0����&�'b�����?��0 �f ��k�)�Q��p���c��_W����?N ��������z��������� �D�X���	�� �xN��x����?y���m/����؝�U���'B�>�?yZ�����ס�k����^]Z��'z���x���@��h��r�������v�R����+U��Oq�G��v����JE^k�N�*�t��/q޾�����׾�{)��I����˅�!$S���Y��p*ixٛ�J��tI��������U����Q�aƯR��)
�lB����5��i�E�^?��j��q2/e؅���LK����.W]��deܽ�t�<3�A*%^��6���������R'�?��
�4h����߷���У�?$M ���?���b������ ����?����q����������?v �����b����Gd�������?��������?iP���(F�&���o��)����AS�I ,bҸ�`�Re�J���WX�ԁ��τ�����|�,6��J��y�
�őS�[B-Ukp\f��pm*��G��R}���-�Gtn3�8۬�3�飜|�O���dj��f�`2x��g7-h���~���F��K�7�31��#�|:��n��x-�0���!�����������8�?��"�`�@��?�� �`���� ������@���_����Q��A:X���������2�ݝ�_�>
��P�\���z�]�o�>�����%�ܿV#x���]׹z��m*MJ�W��JyE��jH���3�$��t����M./y��s��j�4!��{]�=U/O��ޓ��R-�CӰ�l�B k ���pT�3�֙�-,p�Vj}�	�v1иS
x$	��A����9�V
JU�����.��C$�8{�6 �9��y�5V�yOmwة��5˲	-5X�A����r����J�A�i%NH����35�PW&|���.Р�f��[�q��R)=9ת�n�6/e͢-�bɏ�aڻ�R-9�;�L�K#}��eHO����{}�!� ���!\���������8�?�������B�����������~�ގ�5e��/�cM�?�A��_�Û� ��a��+�
Á���� ��_�?�F���E���t���TqM�P��P�2�`h�PL��1��t��paX%aT1�`Q�%IJ^>�a��3��)���!��E�]��dR�[��m��T�כ*������9|YY,�Ҁ���HMm{V!I�6u]Ok7�Y�RF����u��jC���6kh�*B���4�C����y�z�s�7�v��=j>���������C
xX�������P������{~��(���q�����_#�[���g`�S�����?����=b��4�#Bh������A� ���G��r������?9 �����q�h���	���FhaX�0YLU���b)T�(D���3u!pM�L��Y�1M�PX�5P�Q�Z����������B���%�j�.L�%���̋cj�H��=�k�\r�,jx����Mh�(��j���V����Ѫ-�FL�����T���ѳCiY1�jˀ`İ%8�f�0+&�E�jTcLi��*��}5�0�c��I��O� �����@�{��,�'��ǈ�߻N����(A><���?��
�;�������W�+,��d��c�,��zs�����[i�C��C�mO,@�NT�s�
:�(p�u��c��6�\���xb{{�ʝi��@6��dg�=d^\rKY��2VҊ����rOۥə֜_r�uA�:��u�*{��(�$zc�u=�م:t�j�Ks�kY�C�k�]�:�8ְ��{������Ll�)iUG�\.�u�����h��G$����j��ԧm��-�Fk�Y�IqK�{L
�Ic�2n��i5�~��b��SMQ3x&�#�/��q�����ե%}�+|c��wS_�����DrJk}|m�$����-1��	��n٪��[�S*YX��hu��]��T�6Һ�R���K���R9�4.�.ܐ�<M9�=�K{�!����,'�D��R�>�+�����
:+Lӷ��RGO	uft�z�⤶��L(����V�.�崗����)=�&�������L���΃�B���"C��9�����X���5���������` �B�?����?��
^������r��0l�xo���BV&�����g���S��Α���6 �@[G0/�s����e��U(+p��������D<h/ ĸ>�,��M�Vz���9��53Nٙy�L����M�9b�z��;4U)�ǌ5[)18��uNF�4���nǵ�8�\<�a@��ǃX��й�����!P��5�7�Y���+�
��nɮ)��w2�I?]��Z���v�/��=EhIr�V�S�V�j!�Q�z�(-�J[�r�s�O��X�ȉ�?��g(�T�� "��߷���O����BA,�l�G�X��`�?2����������[��|�'Q��a �?J��������}�F��/����P � ������q��0���
!���N(4�a(�R�J�,�1��`�Θ�����J�����Bi����(o�0����T�������g����\3�H��"��6-�Y�	�nvu-��r�`�e�ae��:����7�}���y+��LiN��K��̙�"���B�������i�*V ����\�L�{�����P�|S��(�u˨��/�����a��m�݁q�t^R�3�(E����|������jw��Ӂ�/��&�Q��ڎ�0l۲�I����M(�A��Hw.!�p����G�L�9|��"��adh�\�q��(�^��^���}���k`_��;YBIl��Tb�(h�׻v���eEB��&~�ӄXJ'���oy��X#�[(���]������*��7������g��&.���"��m�c�
���:��^��\$�[e�����z��f%��Q��H|����`��ḍj��b����Ř��n�/v������R���{PO~oi*�Z�_�{���lI�{Г�5�u�A��b�����KBp%Q�Zy��ふ�?��-���:۱�u�ƶ�F�k%v6B|I]I\.ߺ����M�%>DJ�/n���r��.��nR��E�i��0��W�-����h��pM�@ۏ�3���I�"�F�sq��Ι�3g�9s��ٙ*�)e����u��LN�ƚI�L���0tK�֓�C$�i��sMUi�-֢d��0����)J��b0k���{�>�rc� T�@3��ܵ����ƥ�i�����p{}���u����/�����T�=�ב.1���O��k�����`�ב�Dn�+`�e J0��W7M��9ΊK%n��>-�7@j 7�d�5�'[��l�B�z&��4-�,�F��S��U��O��,�D`�&Bz���X� ��.!�sʥ�j�l��x��������H��3`}S]yb���w����������}�N4=A����!@ڡv(���������)ƻC�}�@�	�x(� |t��}��}�!O�-��g��_z�/�������}�Ϳ9�凿��+�������;i�ѵ���?[G���
��u�C�'�軟[����O��w^F�e�k/O�����lj��v$B9}Ss 27ٹ�x۲77L��}s�$[t.[��vj�-w9�����~�&���I$J��F��>u�{:T��vZ� ��;���f��T��i���*��Kq��V�n�8.�U�Э飚8��EzXiƏ�H;��W�o�Ԯ��f?���SY�n�E��y�{�0�T���?B�1:�f�xrj�̰�-g����A�0�Hx,r�m��6Z*�G�^���w���9������� �f:����@Ƶ����ؼo��y�2����CI�U�2;~Z���y��}M�Q\<<ks��{'��	�w�	G�y���G��M��ac�X1K�L��m��jW��1}$ m�dk�ԪѬ��(�Gh�K�^9�!�H��$ݙ�N)�ו�N�F�3">�3�?������J��*A�3`�2���x���;�X%�����f��j�Hk{xA��H.�$JTH�19|N�� O���Ӭ�����#�pg�����Uo�I���Z&�]*��~���H�T���2�q�n��p;[�e���'K�ӎ��B"��2K슘����zJ���Q���3�#ZJ��x��:4^,T�,Qi"ރ`���JX���!�J,t�'���p5�n���H��k�Q���c��g+��Ndcս&��f��B�,	���� O���,I�GFCo10�G�>��
UJ�ٗC!ܭ&�b��t�-�Иe4n����=�0�K��t>���n�VT�yO �k�f/B�-��1�p��f��̒��L!M�����=A
as�ֈ��ƞ<����~����^�a�:�C;R��%�ݣ}%7nԚT�Cy=1"�w�9D�y.�,�V��S���J;5���=w�T���� O���,��&�B�`���a�=�X<;���� ׉Pv�_�y����Y��lvx�(��D+��U۾q+Qη�Z��<����)��,��f�l�Ͷ�Ͷv���m��^���)�$�N����5t��>���ڳ�'�K�I!b<�wQ�~�Rf}�Zf�qkSE�j\����#�S
݂�l���ϣO#Oy��<yy6��8Q�y��/��#ϑ4������k�C^��>�"#+����芥�g"�#Ȫ\�t��<)��8YGnjؔ�1�~
������ַ��o��M��>!�m�ٕO���{��	�]�0/ҝ
�ss���3 ��d8,�M�6�1^Xa�Q<���w�[d�h�7���{(t�hnX�;� �%J{p{]Go#�t��W�4���_	N��u��OV�����zR��(�K/
�>w���O�
�H�]j�C�pd�"��������c�<6a�H+;aGx�X��Oڡc�0?��þd��g3���X!��aE�"�Akp޺����u}�tW��M�3<��%�����vb��]9�	�#B�HF�2��;q����l����q�pX�V�q�og�2}h�Í,��X9����^��C��� �d"��3i��)<�,�Mك�)8�T,��x9$�5���3���(�t���8�-p��B'�B�@��T��pE��F&�����%�T�G��v��m90�t6�Ñ<��;�0=H�a�%��ӄT!���6�!���xi���b'�%N>S~�p���a�-�ر�+��3����Ÿ��!�0��0m�%K�΁� _�x�5)pb���\˳��W�g���z���������-;��,��sk�Z���|!���Qh���V�Z���d1��G�j�6� �;E�)���A.�1�Bt��-�d��aj��ȴ3� u{�Pk�w�iE�a~N��H���ɴ$�w�B쨧z��^�����!��z�8މ�i�O%E�?��F�@/��D:�ƒU�3d��\�r��T��
���}:�&8��(I����tڷO$ݹj_!�Lo�=�hW!��A��xl ]6��^��3b�Z'�x��#��r2��$�m��a��s��.O��nĻI���>�O��~�ts��8{�ѮK[X�p����M8.d�x�=~Ke�eS%�p}-�[�Ͷ��������B%)��	lI�TZQ%�[��? =g_5<�d�!1��Ȁj�!�єn-tr~Y5*%yV]huQ]An�����j��RTyeΏ
Q��$������F&�]?���~�+|��7���~�o����������,z^�@i�:y�����4�.��DQbe��Ԯ:����87��;������kI����o�ß<����ѭ?��_D���Z��~�}��Z�����y����;$����8��+�Ŋނ��t����������ǿx��/w����ϭ��k�g>�������?L#��L��d	���:��th���N;������0;���������i�!m�vڡ�vh�m��6��!�����z�A�˄����z���Q]FF?�( �,x��W�o���P��������}Kh»�g`�uv����jo��q�p����\"F�Q��01�޷|fs��e3c{[�of�����oflᰅ����������:�̹{�n��֖��p�G�0���K'ZA����c�.��9a�<��DH���s�?�v��u$�.���2�2��TH�v*=٣h�����*�5�5�sB�u#k}�>�b$�X�a��`�̀:8��g�Pa��]��s�L{l Ԧ֎Q��qh�!�
��{ z�W�
�Q
 ��������EiȺD��yL�3�H,W�m����*O��$�����-�:@���(a+1 O!������d��(���48�iTW�)z��^[ �(['KX�����R��+�����~���"�+�b%,_�"�\4UN�s�W#s�X:��na�h���� �� %��F��L�`^, ��kr4����`�$\ =�z���d8�2@���.��W8��6�#���g渏 <[�x�IU��v ��y=
��%�6�5�)��4h[�Zb��w|X��WF+�j�S�u�E��� DD>
0J�@�3�@����R����.c Ŵr0nz�p.\f��mEJn1�TYkEPy^oY>�So
��M�iwb����&昹2�IC�h��8^3�YV�@ǎe�����N��e��Ξ$Ҁg]��w�K�X���}[��Յ�N���_pl`��&����kbN�������j4"�I�q�d���\�G���,�-��8�^�(*
���@��&����E�X� ֧	�v�
��1� �,��`{�����Q��{�sZ1Q����׫)1
TO�d�ܵ1��jO�16��k=J��؛�0:Z������<	���{��s>hb�T�&�>c��	�n, ��@`0�����
U�\���"�O�y�E��b7�`�j ����F�Vv�>A����Y�@(� ��i������@h�Nr��&婢(*����L>������Q���2� �M��Ҁ,P	�b6��or�I��*J([a��6�H9a�.E+�&�с=��g�!��u<�83`��*�[soν���c��{&��4Y淁��yvz�M�`@Ak��;t�t���;�z�1�e�N϶H�B�X)aE`cR˄}t����Pτs��й��a�nh��O�W��������ؘ�', ޻80�M0�A�����{�,0ϱ�tQN���:@䡕���iM8~J�gTeaWk2���rk�;��˧C�4Ӻy��b�4�bZ��{gJ���t�$�`��,X��s��|3rdMS�5�S(���[;�ul�@}�ҦB�F�iR*�����TF��y�d�{KH���.0�N����ՙ~���J�26�ց�q7P2�:8E��:�����-8�Y��cAA��",�vFI����F�cI�y������7��,�1#m��81�r��s�����f]��FY���L�TԩU�5il�8�;�ȃJ���`�{�ü�(�T㞎�|���=��4-(�Vs���:@[���y�8^_0�13XCe�Lx��=��o���� ;���|�8Ih�-�x��3#Xh���^_
�9�)N[{�Ў3��V���<�c��Wڎ-̬vV�É��{���s;�4�܃񘧼�}RTY�=����"y P��g͊δB:E�MՎ����������=����Y�Z�O�,pQ�X��o�r�Ld0�R�������Ra˴Y�'D뤂�(zLR.&ܩ8��jЛ}m 0b��ANZ[O�`:ދ�65����I��g����N{)��1���u��9��Ǿ��Z������?���">�mf��B^\�%��8�B���~V����^� �,��}�<7-�0ݮ]���
.��+��z�ֺi�����Q�e�p�%�U������y�,��ہC�Fbh��i�IN��29����,]�^A�t{8t�j��N_�3�-[�C).����|2�X|y�����M���' �����t %q`�W�F˖��4�9��ny�n��Ђ�IĤLT��y
71���h�v�Յ��N[WS(�@b؇��!�}	/i�)]�1#M��>�_�l,��q �X��
�@.LoJ�z^W�h��`U���&�L���5�^�q��]�.��	�j@>��T�{7S'��/{W��8�����+�i�NϤ;x��0aO��ӓ7vc���ߪ�fIw'�1��h�K���9ߩ:6��j."�!������g���\�E��=��_�ӷd����~R�:�~��#��3�� ��x፿�N�j�h�=�
��~���DS(�A~.�E�& �i	!S��� ��^��!!Uyڐ�5d�6j�ԟ.bz�L��Y����@�	1�+��>��R�>s;rŰ6`$���dp�ΈpVfDO�d�O�����雠��y�����v�ƛ�8^}�"�y���y8�30����'������'/���b�����=)GQX�/�b|!C�(�!:Yu��L������	����{���_GZ@p����t�������976����W��tmB�����zX��/�R�i��P^6槶j��2-�8��p�u�&P:/����%�|�����% +3�-}Ͷ ��9u�N��n��v���%"u(��y��n��~	>_n2���"�n?.SӇg[�2��L��6�#�w^�h(?�cB5c?y���S���oN8�#�����u�}��H�:D�s��/�&���
�E,AhF]+\&A.����3�/�ϥ��o��s/pH�|��.�`��Sا3^Ku�rƊ�O2�4��:e��٪`�)��P9���@e ����4��4@�i��1��~/���֯�Ɉ��V_��B�!��:�	���\#jT�e����L�:m~�G"*��\f����L���p��s�ם���HS��o4~P,؎`��=b!���z�Ce�.�GE�z���v�����@uB?�����w$�uF�A������rs�U�������P�)���8���!�|��_,��j0��|k�
Th�%R�_G2l`;_L�+�8uSՇ_MƼ�Z� ���8��u��;|�}��"�l"� ��c�&�i��T�Dho�]�{�>�ڒ6��W�G�´=���_!��N�_��#������{w�_�o?@�$�HL�;�<���7�9�^�N�5�Z�^�����GPr�n���'N\���~hE=9*��H,Gh�s�M�(5.��%���
�=ܾ���1�N���'��Z�	�аn�TZu2���`�H`����$ݡ��`=��� ��[��o/m�g��`����uG���i���ox���ya�}"�q-."΢�4��A�����!�^��W�����bfN�9T�(�G�=���tGB��d�#Q��u�?
���I�B�m��M�-0@-_��j]�>���sH엍�C��"���T"hº`�G_'��#�aU}��bj�� �<�"�!��P�$C^�5&Hg�=�=�qQ>�c��.�#��\wi�L:5�S�������[ݶR�-0e�Z<0��IMR����ʩ��O��v��������#�0O#���c%_(����Ή�{R��`{�9�p���L8��q"iNG��:[�y+��eu��TY<]o=�C;<�,��-��+g��ޑL�;����F�M�ܒ�C�%�?�4������xK^HK��u���n��]�{�h�WT�zrE�ޝ'	��PY֒b�\�O ����>.|A%���+�R��n�%r���q>Eo�Xt�����>�eTW<��@ݱ��9 ?Fs���Z�{��5{�6��vC~W؀�l�=I+4䂩,3�O�#��^��}��(��d�v!����Q�v����/�B��
GDV:�+�+���xe�+�����������}��~ke`_z�{?�K*���{�����aw��r���o5 ery8��L�I�qvLH�
�}.�
ݓG{2 ���0.����/�	~��Bj�'���m�\�7]RuL�7��7���m��'�o�� ?����>,�a�|%����eD������R���>�˰p�
�r�����:
a��Jj�]�N4�5�!�r�3���H�2v����l,PTu *�Dsu=��C�(��E^ݐ��.H��/��nF�ʺ�Dv��m�V 
H.H-H����	�>,�m~V�������j�)R�NmԪ�L =�tF�T�8�P���Y����s9R�GKWGL/�*|R����//)���)<	w��)�0�H� � G����c"�%rTl��C{�+{h�͐��E*p~�Er�;�.��S���!|���h���a����x7�P���6���r�:O��cu1�����/G�@D��PYK}MA�  �(��r����l	���aa�]����x�--��cR��c�	�G�xV 5��Ƴ
y��y�)�^���v��]�?%o��?������$�����Af޽���������s��,�W�?K�i�������<^���p����������,�N���CnS����ڳAu4��G�B"��P_���h�>Ms���N�9�����o=���Sy���r�̏��Xb�8�����i��qH"�g�����č��K/��������9��r5��)^g4V��0XN���J�<O�\NˤU��sǙTF3i��2YFW5���4M�i�����J������Q�������E"_͒
bK �M�+�%�"��og���А$Y��;��v�9�[����'�m��:��O�n-�p�jaTp��'���'��Azi�y{���TU�<O��֡i�N)��ҽ��d�:9�q4\���`ӑ��SKf���i��]�F����fZj��gS�i�w��G/T���PI��O����?���8$��fG1�������^����}�����X����
�y;7�k��G��t�e����_���������|��מ��H�?�������_�����O�`��c�I��9����9��q�����:� �$�����?���8�{��4��f��S����+W6��b3_�Ӕ]�&^aГ+���S�pD5qɢ~�AM\��ܠL��Q��N�)��*LM,������2��ה��)�{?�^[�v�JS�ɧ0dɛ�������m5k:T�=�(�{eɣ۽���9�jVm�3�ux���E�ՅE��Jq�I^�4ZAh�P��[N��]~�-'���jm��O S�.4ʩ����� 2Ь�o4�"wK�����%xQ����W�P"�|��ɶ0`*���[J�}m����&�"t��m
��n�1ʈ�Ӽ��>ڧ�Flz����=��J�IMa���]��yv�>��U�sT͛��Vk�L�� �r[��W�=C�
6;ɏ��v,�4��ň�d-B���r�|x{�T�������?��␸�������O�`��c�I��>;������Z����ɐD����5���������$A���?�'��4��&�����_"�����č�8�G��?��k�?��q=��gL���I}Ń�Z��29�M��OS9�ϳz��s�pf_�3}��ٜ�1p��_"	�q��+�+�*u��}�6��{o���bm�V���ʷ:�P��Tk�L���,��ZXWz�qz�\���n���z3cv�<��W��n�2�ZwbfKl�w�O=b+L�I{B��؅�ߘ��}��sOs��Y�du4��?�*IX�q���I��?���,����^����8������� %@`���?W����������q�8�G���[�K���ד����u�\Ia���W���1�����Ʊ�XM��(��Rh`���������}K|:��>��Ƕ���������|ޫ�E�";��G�Io41�B%�+�>�h�����L��|l�f�W��1�m����X}��E�"�i���Y3U���b30<�����F����� #�@�}�<?:����F�o�����Ȟ 
��(ҽ(��7��Os+P�,�.����S�$O��BuRϛ��iW��AM�|QI�Uj�ն�(L�7�vJL����^V��jӨ�Աr�k<<u���\�vk��IE�2����$�{J�p+��P�&�4��|��;��o�J�?��z����$K������$�?��q=��c�2$�?��_M�������������y����4���X$	�?��r=y������K�������`���X�����?&}a�/���"��Y5�����Z�������Y^7�>�76�z_gi*�K�*Ge�է2f��s���(�,q��w��K�?���+�Բ���X,jJ�x|��F�A��gC+.��쮱���iF|1���Z����7��p����d���:�OL��ƳnyL{�T�uG�w4�x��Twg	T���w�G#?|2��`�)�ٌq��7�O��1L���x=�GS���"�����0�����e�r��?I��Og.����_c�����o��/�G���Q�/���/I���N�?�c��Eb�����'����?����?}��7���\��� �,�1�_�Y������"I��O�9*�c���i��ѳ*��h��(CO�r�j0}��Ҭ��}�����~_3�\6g��Q�6��_������x����i>o�NO�s� ͹M�RaK��/c+K�L���E��ç�Ԭr��y-�l*fޡ���W�R~b���N�)X�Q��]��5{&��LGNU�҆׵WbbMk��ΜQ;c����o�$��}��+���?�"W^��� �,�����"�����$����m|Z,6I��G�3g�8��E�w������WS�����?���~.��vw[��`����S����<��ĥU�9PEET�����.0��s��=�jx� <T�\�Vs�[�-៬̢Gmj;a����05���k[pm����5���v½�Q�M�n[i*��e�%o.�7�g+�լ�Pi�����%�n�Ӄ��~�Y�����D�h�h���I%/�66J��T)<چbD�٬���j`{�T/�������X�-���|j,�Y��]k�^ǘ����Ws�yn�ZK��+�ǝ�&��ړ�3��Īr�ɦ��SۏID�D
j�?���D���'�߂�w+7��6��(��¤D�Se��(_��Z3}Tl����ܷ���^��E�X}�d��U���U�!�D�1/	���M����Q�By����J�����嵙[�ą�6G�c���
}��{�(vש��E��g��X5�ͬ��i>N���T);�<X"�?��jre��ʂ�����%�a�c��*���p� �/�����p���8��⿴��_�+�l�K���n��jY�t��/�/���7��3C9�(G� ���80�'q`���Qւ(��M:�-����� ��!���pw�;���.�颴I��ݒ[w�^���J��+�2{�Z>�,����qv�j��C�弶!(���ɷf��Vm^��� ��B��� |s�x��l��{��֯YRo�������.���-���k������6�d7�l6r�S�HfkՓ�=mQ߲�O��V۲ܢl�{�#PTI�M����n8@�9�, �i�Kr�!�ނs�K��s�)�?DIԗ�[�̰fڒX�^��z�U�*93,w���/����e�8�Y{6(
���������w�ջ��N�t����߿x2=
�/���Op��Z�'���� >q
�����(��g�wp��Z�#�����'J�"���?Y
�����`�?X����?�����Z�Ƿ��- Az�i����?�A����(���������5���� ��i]���?�I��:R�����']����}���/�J����d"���4��ݴ��Mw��L��S;�D;�-��)�H73�]�m�(�g%)�l�$S�-0/=�����L&X�YKZ���|����X{q.�k��c�����-�(��P�����Ry���<��~ֻ�֎*G�du?uP��n���l�4˷�wG����%8Q����g7R�ɿQ=�}���yֹJ'
��˲�L윾*��I�41��yhz��k�J%t�����u,�����q�� 8�k=�]�@
�w}Α0����ٹ߰'�޹��]�2�/�b1E�D��fn;���m�{����(����OH;���a�=����5̳�q8�[�C9��7T��r)�z@M�j���kzw.*�~��rY=�5��Q*�b\�-E"�NGt�F� z��{w�;�g��%�A�[N��-�W��Q6�r�Ք�ǝLY�Ѯ�73���@[~_��?���~W��4������A����S�|��Hfғ�{����'q��9IFB!dY�F���9�%�ء9��+��w�fI���d�t4�Źx��+C�Y��(Ɯ���d?_����b�鹽5��/V�Y�����Gm�e0�3༞��r�蒨D"�8�I���å���P����-G�"P̫�� נ�h��Ӓr�o!��M���������-�
��US�U�7T�\!�Y l���I`'w[�`K��S����b�^��=QQ&���BU(�/�Z�9�r��_�k������Ճc��?��f���:�/�j� ��9��Lh��B��VK{�9�@���>�a�y3���w��(�	���lb���1x��^�* ?B�2M8Nl?A�Xh@��yh�����v�a�tm���$�A�(sqy�l�#s�y.�Z�Z/慽o�]ݰ5��9��o|%��#u��ײ�i�d=GbZߌu��hvc�.�:��49P�>�<6j���>�г��3G�O�XJfZq8:�!��OW��ȧ�j=�4]ʓ9]����zN�R�՜���E����sO��3G
�1����>p ���N�������~1�""-�mʷ,TmM ����SV䷔싃[SS�@��jR�-J��*�Ыh��gvw�9��Na<��#,kAw �J�D�Z���|��X-��_<���r�����vѹiz���|rаt|�/��c;�_��L}@��W@��N����@�o!ċax���>Pc��^=�J��V@�:`<�Vk�b����ܘg�<-VO��������F:b>E��P>mTk`��g���<k�1枍�����ݮ�[h���S��(��vb�,Z�9����xif`�l�S&�mMQ�!J�AM�}�_j��e���A@"����b�Z�JM�D4,����+����fI�vx�C��)�.U�G<�@u��@���Qdkϊ�Z�-s�,���`v���|=_��������g��R������dQ�X8����?�<���$����J62N�6��qV�I%6�4�d��"7�<��9���S���t�}D�f��K|���E�Tm��v�y���5w˘p�g�F��d��?�}��} 9�'�JfGV�ab���lS���r��B?��h�,[䵄��X�KXB_K�x��0;e	w>�%L>�&���{���=�������I���w�pR|���v"��\�Mf�����ؗ!�%9OH5h�T�h�O�}Q�;g��[$��������sD��VO�-b��d��Yrz+Ѿ�.j_EUp����X=6q\�8�&�"B�>�j{�Z�m/#�CNd�r�މ)�;.���&qf�8Sjweۼ#�.B�	d*����B��@�P��DmCk�CQ���%�.7�X9�A�� �c�J�y���0[P��E�~����j��z�H�f�T���'�k��O.�Q���E(�E���c�L{��X�	�����,��}*�mY�����������htA��dG� [�F�{�i���vaE�P(�C������PH�&�%��tꆻ ԩfxa�&y���6Ɗ��e��n�7����0�G�=7@�8H��d S4c�E����l ��"��(\oA��K��u:�Ui�����Fd\y�VZg-����́�	�B���ψ�c�'�mވ���"�Ir��h��φ�p��Հ�k
倰C� (EF[y��-�ب{���0Ɯ�j�)�����4Y�h������ᱬ5g�����&`�'�M����qj\�Nk�k�)��1����	���A6�X�Z��ȉ� z⵭�,�C��[�ȭ���$�Hdb�F�b5�78���p��b6�R�	��tˀڳ�9�-�����0��bM�L��9�w�:�a���܅o���m���oa'w����ܛ��bs�xះ<$�nj�� ��ں��@���	�^`|l���	lQ�p}D착����<Е���wc�0E F������C��� ,�~��� �B!o]�D��R�i0�f׽�k�}cl��ɦz[��bpdX�M�z���$8�:��,���6P��hê�8�r�ޢ��W76سM�����l^,���qY���ZA:Ԛ�aK�Dn1��ġ�!T�!D�NԠ� *�7wvm��tP����ca�CeB�X��#jGg�7�Q0��
���@QFգ:��/"��/"���!����:���gsF����WI��ሉ���>s�g�FY��"�y�/ʊ���^o	G"���s���յ!�&^�5͠��e2�l�b��K�Ԏlo�.N�ssL��Y�Ͻ��������2mE�K7��ҫnK;�ݤ��A�պ�!sp0�%�E����x����&��r:8�sa#B(����Ud����e� .����p�P�{`���b�������h��[^O�󎹟@
���ă�1�a��L{/��������ÈX�Kd��M {�q��W��n�=�<��#�gЭ]0�K��P�M��ctʈp�t(��#:�3���� -�V��S��g���]��E���S�?)|���!=�Y�)���htC�����M��h�:�c��gBOYEMq&�.> ��,s a�������1�i�����v��Dj��=����B��V俉����0������� Nmh9\%6��]#0��Izr�k��K��:���Pp��94�m�D� �8�[I�q��t�"�ߞ|�/�N%��֒>����؟�C��ES�0��`Q���b1"ꩵZ�٢M�Xz�����w�/*$A �rs�?/�q���㿒��T�Q|h�OL���N�����#=^�_d��U�;�oH�����Z��)+Db�r���+8c/⢺ICO���m�1�.�ެ����}]�y[�,h<6��k����p� *���BEuu�dE�_�����H����l*x�w-�������1-kfU�ϫ0j8���S�ȠܕA��5S�6����>�8�q{P�(����x_$�>����)�"�'�Q&LV%􂴶5jv���@�w�����a(����{yB=_�7�=�_)��u�kR�������}�M�����ES�F��8��}���_=�����g�m�uj�Ŗ`��Ϧ3�������������85༌�}�{^$*�U�w��/��%�(I4�W_��O�^�ʉNB�����:��<��OŘ\�;�¿Z������
��	�32Pov�zw�K/3N����F~���� ֲ�c�k�-��-�iR����������-E�h�cZ����˾�!�������I� ����u������?�-�Tr2�K��)=��o"��@ʊ�b��u�u������?�-1����MeR���%=������R?{�vvk���-3!��������sJaUK�iQ�p����?p��e���?���%=V����z�Ɯ�����?��|+�-W't�v���h�ÞQ3��T��ϴ��ͮ����"�� S㿊�_�?ߴ���tvr�/�K��!�(N�������>q`{8J"�|����>g`�
_)�5�v���?�����n���d�z}�ή�x�Xo�{�$�I���:�#�G�ϛ���z�����砄9�$�:!a��D�'@�L=>=*7x�S$l�3�8(���ՠ��e��xV+�/�Op��U���5��M����5��W^�{B�j�o�Z��kw��Xm�@Hki*�|�w�7�=o�{�(���S�L���<h���%�?���?�����G?�c�;�?ƼBv>Š?c�|%��-��h�9��a�����>cb�Yp�B�.zs?#�D��v(�
����
��sܳ`)�~W��b��K�/f+�9����_��
��Z+���/���-�Ȥ���#=�bm��h�L��=�0���L���7|�x�Gjj�7�H�d���?晋�=d�����L��xÈ���
U�r_��ڟ�bl��;;������M6S�u��쏰7H|���ֳC⻝|�_��q�c�˝�H���+�˦R�D��O:X�[KBU�Pv��p��KBo:�th�E�s�Rj{��)�^\sc��PʡJ<���bl��?�Q9�@z��9%�H�]Mg�*���#�0�:�,��2@�5�5�H.��	�G�	�2`g`�.�7vC��?�J2Ţ�vݒaC�4��+���c�J̈́���������Zl�]���FU��5*�RW�a$�;��(~0U�Y�� �#\��%�� $�<�펨§��[��Jpi.>�#l��N�8e��XVp��#L�sf>VL�gg��d*����e3�lF�`�o-)��cpW/~����������������_�y3�Nn����nҮ�+&���v{{;��ifD��3�f�ݎ����m%��vBJK)	
���!7������?����O���������߼���_��_=��Q��G�Q�?��ѓ	�~�>���?����OC���5O��?���C��_������ɯ>���.�Ծ ]���l]j?��g�����<w�����!�r���+�T�ҰrUV��Ó+~x��uƟ]�/��ӇJ��[�K�וB�pg]������xwj>^��v� l�φڽ��Y���kƒ�������E�x+�'���Ł��Y{�R�0_�.G߾ֆg�;ٚt{����&t�W��_�=O�W�W��-~�b×�J�/q/�_B3_��ޫ��%�_<�7߆ny�h�Yi��;]���*�Ja�!)_^V
b���U<Ĳk��|�?+�_{�:%�V�����N_u��'���|U?u��/ϻZ+���i[�;��]���Kwb���u�H�Kt7�9�O��j&suY:ʗb���ݟ�Ï0M�L�*ZL�)������qܪ���n�w���^�n�ڑ��U���
Tz��8v��q~��8?N��I��iR�� B}C��*�P�<C�<�T�T��*!D�}����L2����Y��3�ܜk��{ιǟ��3~d����J��LF*T��:fH��	~owaITK�5M�X�)Sւ3�tWn�x�X�D/�ׁ��w��h�wm�F��T_	'<���������ym�f��ަ���������!O��/1l�)�e�Ӄ�YP6�:ƺL�+����B@KS������)�0��7����Z�jI�����w�j�1��t�֓FX������M[�l��<i�mKg�H�*�Lc��v�9%EQ��,Q�+��傮NL���H٨ą���#m�$(���@H�[r�R�w�r,��N��M�)k	�������Z�M�S~�L�)�l	������$��.LV����p+F�2+��207W��RWJ��.�J��)�d`\^�T�j�i�-���	~��{\��Ns�qG:ہ���\0�Д�P,lSz��uoO2ha#�=��f&\�q�Zߡc̰6m��zц)�1�M �%O��Q���\.��ވ{��p/_��jI<W����5�֘y��aY��K0���)���N]�d�#�[.��NY�M��iCo��@�Ðb�	C�l���jc:Y����{N���{�B�E�#�q��uM��'ɵ
,�vì&[ �t��S���'����q
�̘/�~�!��"��C�����p���܌���2d|�9�:��Z�]�fx.���==�v���B0((��Q�t�Fğ�|O�:RMΔh�d	�;L,�Px��{FƢ��X���^q:�L�Z�Ć�H��?��宁��7	���d9�}�ը	��t����M�s�VO�J����/��Y�j��*��9eK�%��kQ�����B��3�#ʇtok,�(�X�#�1���i#%�K��,:�����F�LOjAba,3�Y.F���4A��,ߎŞR��R3���g444���ne,�-�Ż��tN`,�r�H�t��H��u`�bkF��Κ��k�D��F�|'��p ����8��z��g�Ɛ�D��2���錅me�Vj��(9JVm���J.�/T�8f,G����Xf���D�M룶'����K�L��r�ݥu�,FU9,�`�6����Z�a��zNod�iK�EJ�����lK���LG��IW���좜�l(g;Yζs�� ���Ҩ=n��K���a;�v>�|x록K�����J�����t?�Qg��Yg�����~�K�<��毵�?D�'c�
�x4��������ܜm��v�.Cc����e��������-�.��q����m�}g⨳A��΃G۲�*���Ek
m��=�]��7o�E\�y����]w�5���g0�����py5k�ծ/Z�=�]�_����ݶ��/��Y���΃�u\���-|�:�6Vk���a;D��7Z�h�g���b�  �.6���N|uLl/��W�,��O������o�������zש[�O�Fv5u+R���B}�(QtR��t$�D�E��P��8.���Ϻi�質\hnQ4%�J�s�R5�ʢ��ʖ$JYN�$��$�Vg�R�v��ܩm�#ݒ���o�.'��CUZ���tNEʀQYRb��$�O��4�̨��,L���@�̭p�Lc3�X�
,2��fm8�ܻ���C!7d��D������\t��A�׭�T�,_N;r7���!0<��&9#jʔ9-�����FjAr��HYǨ�:e��K0�0ef��8@:0����<y��Ϗ��h�����b�vŕ��)6%�-'1�����LA���f�ӗ�������MM��74mx(2�����dˆ:!�x����������$��L���9�iX�^)�@���*���D0/����O5�;:�.r��9�ǆ���g������<�OL6k�r�� ֙��gŧ7*\�.�+伫+|�+���K�cr��/�9�
ߗ!i�;H�I'��8�w+l=KT�pdd�����1�G�G&�CQyvۨ܁prPEV��WPd�*�E6���Y��|�Z�!G�pQF���h��L��(kF��$Z�c���$�����ĩ\K�!1a�Lu0��.������gg3/&��J�"Ĕ�
�M0�(N�`!tiZ�p�N�F���z�����OHQ�	!$��c�l<�s$Yc!�0�[���aތ��׌Z�:�6l�T���*2!z�Ǖ`��i��Նa�o���b�{:�p��J��N�Yjw*�	�$�B΁����9N���#~'J�§N��8�u"H�0�΋��l��c]Н�VJ��hb�'�Z���@.o�o�#��^����p�^�.�6�^�J_�_��'��i?���0l�/0��5 x�^y��:oR0�`c��������+��(��ٯ�{?~��W���w��뫟|{�i�}}�U���䰌]���z�̚u������$�G���z������ܛo��_���~x���v��˙�/�����y����q�����x=~�q��ֹy�����+za��_���ul��a����7������7v#��E����}��>�?�؟7��o�b�v�����ډ���&�h�ډ��~ڟ�"@҈ډ���ډr6��}����[�G>�S�*OB��k�z8���^����!tU���g���11t�����?u�`����x(�C<�(=JE<��9��8����d�u����2��eZh�B[њ�, -@kf�s �kf�a��=,��+sn�5w
h�����.y�ɜg�/]w�xh��	$H� A�	$H� A�	$H��g��   