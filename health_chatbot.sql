PGDMP      9            
    {         
   health_bot    16.0    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    18406 
   health_bot    DATABASE     �   CREATE DATABASE health_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Hong Kong SAR.1252';
    DROP DATABASE health_bot;
                postgres    false            �            1259    18433    english_answerdataset    TABLE     �  CREATE TABLE public.english_answerdataset (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    expression text NOT NULL,
    score integer NOT NULL,
    keyword_intents character varying(255)[],
    suggested_action character varying(255),
    elder_question_id uuid,
    progeny_question_id uuid,
    question_id uuid NOT NULL
);
 )   DROP TABLE public.english_answerdataset;
       public         heap    postgres    false            �            1259    18438    english_questiondataset    TABLE     �   CREATE TABLE public.english_questiondataset (
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    expression text NOT NULL,
    keyword_intents character varying(255)[]
);
 +   DROP TABLE public.english_questiondataset;
       public         heap    postgres    false            �          0    18433    english_answerdataset 
   TABLE DATA           �   COPY public.english_answerdataset (created_at, updated_at, id, expression, score, keyword_intents, suggested_action, elder_question_id, progeny_question_id, question_id) FROM stdin;
    public          postgres    false    215   �       �          0    18438    english_questiondataset 
   TABLE DATA           j   COPY public.english_questiondataset (created_at, updated_at, id, expression, keyword_intents) FROM stdin;
    public          postgres    false    216   �1       U           2606    18490 -   english_answerdataset core_answerdataset_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.english_answerdataset
    ADD CONSTRAINT core_answerdataset_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY public.english_answerdataset DROP CONSTRAINT core_answerdataset_pkey;
       public            postgres    false    215            Y           2606    18492 1   english_questiondataset core_questiondataset_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.english_questiondataset
    ADD CONSTRAINT core_questiondataset_pkey PRIMARY KEY (id);
 [   ALTER TABLE ONLY public.english_questiondataset DROP CONSTRAINT core_questiondataset_pkey;
       public            postgres    false    216            S           1259    18512 -   core_answerdataset_elder_question_id_a7c95cf5    INDEX     |   CREATE INDEX core_answerdataset_elder_question_id_a7c95cf5 ON public.english_answerdataset USING btree (elder_question_id);
 A   DROP INDEX public.core_answerdataset_elder_question_id_a7c95cf5;
       public            postgres    false    215            V           1259    18513 /   core_answerdataset_progeny_question_id_a875a8df    INDEX     �   CREATE INDEX core_answerdataset_progeny_question_id_a875a8df ON public.english_answerdataset USING btree (progeny_question_id);
 C   DROP INDEX public.core_answerdataset_progeny_question_id_a875a8df;
       public            postgres    false    215            W           1259    18514 '   core_answerdataset_question_id_1eba0d10    INDEX     p   CREATE INDEX core_answerdataset_question_id_1eba0d10 ON public.english_answerdataset USING btree (question_id);
 ;   DROP INDEX public.core_answerdataset_question_id_1eba0d10;
       public            postgres    false    215            Z           2606    18554 P   english_answerdataset core_answerdataset_elder_question_id_a7c95cf5_fk_core_ques    FK CONSTRAINT     �   ALTER TABLE ONLY public.english_answerdataset
    ADD CONSTRAINT core_answerdataset_elder_question_id_a7c95cf5_fk_core_ques FOREIGN KEY (elder_question_id) REFERENCES public.english_questiondataset(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.english_answerdataset DROP CONSTRAINT core_answerdataset_elder_question_id_a7c95cf5_fk_core_ques;
       public          postgres    false    4697    215    216            [           2606    18559 R   english_answerdataset core_answerdataset_progeny_question_id_a875a8df_fk_core_ques    FK CONSTRAINT     �   ALTER TABLE ONLY public.english_answerdataset
    ADD CONSTRAINT core_answerdataset_progeny_question_id_a875a8df_fk_core_ques FOREIGN KEY (progeny_question_id) REFERENCES public.english_questiondataset(id) DEFERRABLE INITIALLY DEFERRED;
 |   ALTER TABLE ONLY public.english_answerdataset DROP CONSTRAINT core_answerdataset_progeny_question_id_a875a8df_fk_core_ques;
       public          postgres    false    4697    215    216            \           2606    18564 J   english_answerdataset core_answerdataset_question_id_1eba0d10_fk_core_ques    FK CONSTRAINT     �   ALTER TABLE ONLY public.english_answerdataset
    ADD CONSTRAINT core_answerdataset_question_id_1eba0d10_fk_core_ques FOREIGN KEY (question_id) REFERENCES public.english_questiondataset(id) DEFERRABLE INITIALLY DEFERRED;
 t   ALTER TABLE ONLY public.english_answerdataset DROP CONSTRAINT core_answerdataset_question_id_1eba0d10_fk_core_ques;
       public          postgres    false    215    216    4697            �      x��]ݎ�7r������ɲ�b�w,��Hn� ��������ƛ�^��Ly���f�t�'q�R�`mC�.�밊U��E�ц�������ў��d�R�;�ŏ�MO����$�7��J��bUgr�k�!қz�������~��?|�~�ے۟������]�V����Ee�����4���#��⤭��|����;j���ͅ�΋���-HO��Rɪ\ti�-�75�j.-�����������F�S�p��@;���o��m���~z��ݿ����?�?������w�����{W����ãP{_�XB��T��w:�Mp&n��Q����f�t�*8���ZU�1��Rė��]8�B~����~0�ӯ�]�d���&�zI^Y�*�u���p�Q[�7ɻ�P?
x�'�Q�ɍY嘛����v@u����&����(,}ŌK���YA}��9��hb�뀦@:��u��e�Z樬s�b3CUcMˉ��i��|���������������� �G��=��W�CH�T{+��v�MÝ�v����%����}�X����RWՍ�Ͱ%is2���ؽ}���������{����O˖]�~	���w)�W���|��hҚ�J*�1Ԉ�b���i �>�Z���DP54�l������8�]��`�[ F�Nk��:�)��褵�pDI-]'�ad;��5C�O��%4X�4e�J���J�dմ��8�!� k�(�&��U@pa��4,�nZ�X-k����U�C�1ך;� -zҒ�K+qn2w���L0���;�% ����3�w��b(��r�E�GK�T�I~�O�ΈXë\��c�C�4
%5b�M�4�=!������'�q�u�~>JS���<���>� ��)q�I��\
2���Vm�i�->���=���r�$=��il:ǈ*��#�@�eV����m����c��a��Rv nO1&�1g 6~͠�[�T#����`���X ڰ�H�0J=�V|P�g��A,����!��f�hzX���;�{��l�F���`-�=T�A��\�/�=�&B� |uzXr�[ ҝF�I���zpGO����&������g����^D�%��.�`�=���Dk5(r,	 KYZ�K�����rᓀ9",>�DĚ��5�iv!�Lѷ�~:.�K��K@��~�l������t�w��[|b3�'v]��X[ud�N����3v\B
�p
��H���K��*�:87�P97�c�1�f��}k�?�U��!������?||](	Ujpj�"�2-8$��<�@:n	� g��q�	�I`&��!��.�Xb�p����G�9r|��i�9 �#�[�.l��)0sC��IEχN@B�[�M	"��_CAk#�*Y1k4�� e5Tr �<#@�6^���'s�ҡj@�]&B�h�w�p>�1t��\��j��f�C��X�	<we.Z��6��B�(��( E|7pG��m�UŎ�����u�J���%{aiVP_ri�h�&�'���1i��P�/1��N!דM�5������R� k�h��:!sN�(B2�-=�k���W(XŚX$��٢�=tQ�������Nk��۽��}�a���I�P���%$��ʕ>l�5�򘺏f�u��;��:�v��
�`+Q#�c]��s��	q(y���8��'v*���á!&���+(2�Z�>�������	��J�'44�����Q{󃋙�4|&`��\Ξ�0y�ke����񍨥����M��K��/ٰ7Z�e[򥀙����m�f�}�*ke�,>�9�Z��7��VX�[ �;m�!d�� ��Lž��%����$y�,?����o�~��j����O޿����{tɌ?�����s���H�u��3�Rw���������S��X�߱��K��Xy�TރB�Q�x�������b�g)�n���vã����8D�\GXe|%3�K`�H�D���H�jܯ��6�M"��-��#�s��[z�]�wn�f�ʷZ����?*Oʿ,���^:�1X.�cg�PF?� ˪�[ܐƑ�P�����	5�yZ�;����պ �"���&�ʹ��|��1{�����A �y(Ԑ+�5��|�b��EC�s�gy�`[Wpń+hf�(UoGLL.��wz��F����� <y�D�e���@�⩫��/t�j_��y�?~|ؽ������GK��wp�]�����������~Z��+\Y��%w��I*�v�R�t���#B+�R ���(X$,��x�p�Ź��k�5W�h�Q� !:�q�]sa9څ���D�\Cfɾi���@�VZ�1p��ǚ^�h���՝��̀q#���cs]����z�0����ג�337ll�x���.}��|V�TQur�ZڿAP_rv��FL����G�5���A��P)D)�
�e�}I����j|�4�GV�f_�k8�Y�"����7[9��1�`���Z���~^��ո���(���xA�\&���|��)��]�!�?�ǘ�P���nQ�!#v,�k0@w�[K��������`?��Lٱ��b.�L M�J+((6R"� 	��sF��Ҋ��3���G/I�FFY��bi.�ߨ6�bҍ M����e��L����Y[�ޛ`���I(Rd�h-9]؃�[k�~�Z#mQ���)I������uJ� �>��T���#<�u�P0��]ǁ�dj�L7s�\�2���$Il=o�)0Lt��7e
5��.�N�͈�:���%����kb�����h7bg:$;�י�z25��D1�M��}W�v���=�>�\��(�����,�j��"��B��l��=n��	N�O��[��(��	R@�PL@mkE��3XT�����+�_�2����s��>�Y���Z���@3�ԥ(�dܕ�S}�ޏ4��C��࠻t�u���#W���m2|��>�M�d��\J$=N�piE��Ku��׋��u؇>��Ae���2T�{�&�\BNK�p����I��OnVZ�葜�(����A��{Ǘ��K|�L�\1Vf�%g���u6,6�<
��{qF���tש(��h~�]R)x���#-6ǈGA� ���M�q(��tFz*]c������k`��8�\��KH�LW�T ӑ�`��_���?��Pz@Ǡ��y���L:`�(��I��� �MP��4}�Bi�9 {"��k����Gs'[:rc��/�(�r���1�c�WGP`��4��q�l)
#2lit#<�2��	���S�߻�tq�&�(������[ۍ�/.W|Mg쩬%�8P�8m�g�L��<��*\�v�؍��gs��Ҩ��ԁ3���p@��^8��^�g�W̅�YA}	ȥ=
|���\�4>���(�f��f�U��*'}���k޶Ao�� ���z��\`��&|�G��S'�d{E������G8o����@����1Z��򹀙.�B�T�y���4�P�F�EN�Ϛ�(�@�A;�Hnb'�h�5���kvUߨ�	{9W��X`o��ӎJX~�<���T����l8��mzl�~��aW~��ӣ!��ݿ�>���?�]޽����۟���F����Z���j].��t�[�9ܑ�k��! J=JU�K�(ْ����D �z�{���ܽ�\�����������|��2�"'����I`R��rGҪ����Z�A����ht����k.�,-��f�\ �|��5���I`�� �J'J#G��
���đG�&�֔���Zfu`PR�{,/";�*ܫ�hn�w����޼�'�a���Q��h^��.��\[��~(�Z��Jc%�aiVP_2iP���<o��~TdEi""Y�M��,�hӬ���Co���X��u:�Da��4ilМa:�5ڈq.�>��^�О�n�����H(�|�=��YWw��&9�F&�aàS �3��;��Lo�i� ,
  �J�4a�{躕�.ͪ���?�%#.#�\�u�G�=�	P4�.�RYU�dGڤ��$^"5VP���HV.�4�aƣ�.��{kֽ����.�I`�%ꑋc�?g���Q"��8�����E���u����x0h"j�[�B×Z����{����qg�F8I��P���-�B�n)b�������/����;r��t�T�mNZ�4(����>i���$b�y<��_
�� $q9�XN���x6Xhd��ҹ�Є�H�io�b}g����,B��f�X?����B��Z0��-�=�G.��[��<�|�W2�lSZ��؈=cG�e =�����+��q��=*T#W��`v͢,-*�w!X4Wjip�\��W�\�5&:>G-րo9\d�6�q#>��uڄ�����Ըc�)�C��E�n��Q���_��%�saȭO�z��Mn�e��-5����"\�snϨ2�&�'���d�v��Ь���	�̤t��Q8�OG�%c�\��s<,�I��7"���C���$��0�d�Uٍ�O+Xʳȹ��R� ��3�y�d
L^]�$���e� @�,^�R���[op��I�;�]pN�'�ur)(�\�5�G��hE��#����=p�F+	�0E��'xm.���]��s'2�u��s@V�#j�-���I!l�J �(���!ݛBI�Gx�(��L��[���/�*3�D3D�¬�7�c�}y�L`c:WY��U��~#�3�`jG%�js�E]�����B=6�UA�����e�Dh��(��3�����Aw�@���r!��$����`ׇ��g�\��u���y��x�����a�)��*�-�}ѫ���:���M%����݋)�%��:į�����҇��{q��\`���|KƗs*�τ�n�j����8Z���՜�ی�*#�:/h�?��/O��n���H�]A�)k5!�wp���}�������@�x��L ��q�� �%J��6�� N�1��O<E�������$zBk��)]��>��F��H�(P�)9S�k"�$L��>I4Aٸw�bB�\`��2�<@��v�ɠao#���P��R��K<I��/�$�hH��:�)0G>}G��`^2}�`��^�<m⻭іQG#_�H����Y0|��ɹ�<���+3�E⟭,��X��u�ؠ�/^T�J~�q[��k	>'�J ��T9p9�F����Ϲ����JOj�C+�?km	��-M0+�m����H��w��ƿ�'���w2t�?��b�����lP_���v�=�&W2��ؕ����^ � L�'O��~˙ �|� 9�\U='�坥g�om�@k4����Z�G�RoD�)p4��N.��xKF^��ԈCjLFdzq��kjx]�h�.΢�N�5*y�,���,�G��t�c�����	=�	�"DH�w.p���[B8�0Hnt��,}��!>Ԛ��sBSmfD>�����&�{D�R�g1Ãzq�I�R(&�
^����3�7�I��\�0�U�f-�'jTP���r����"2�B�	=���w�4}�%p:;�>&y��Z1���!s�����(����0��kBS_�����a�������ҁ��qm2g\M�U�Ƚ�1��?\���Ŝʹ�<\���*��z�2��@a`C$�;{���4�I�f5]�3w.0/��"o�T�,7�[P�#;P�rÏ��2Uͫ��y�W����90���x��s�}�T:2��4��6e�"'��F{u�\zI��Vl��|��y��b�62��珠X "P�\�����e�
� ����cH�3��9ɦ�=u�(���ٍ`K��O��Wy*�I_'s4�M�8�{)�z��.c��쑓�y6��2��U��]v��Oݬ�	{�wq[�\`r}6����V��NH})%��{u	�*�b�v��K���������s�����ɩ ϼY��J�7����t�ٗ��DΓv�Y^8�q��'��O��Cx�U��'U�˥�}�����Wy!g�Z��jk�N��y��q�.ev��19�_%�1tS^�B���;�G����ܹ�l�w*�7��-bK	��%��5�J��|�5�f<}�arښ�iC�)06�{����#�c1��Ă�vWӚ���S;��$��B�&�uģ��۫�$���k-�@q������?��g?^������}0�m���<i��1ZB��$N��=��(�kBlN���<��r���7�>S��^M(š�a���B^��F�P��K� �?�U��#���:P-���'�sV�"�pB���4�-t�G*-�V엹�vCO����m�э 3�3�<�EՇ�yLW����#���~��6�I��A����^
��������C2AZ�2 6���l�?�ю�V�<������'���B�jq� 8��IZ�Y��g�6_�����������Xq8]�%;��U�FX1
�T���3y7�Fn�=�6�&X���ܹ���dCh��I�W���!Z�yg��a����mO�ɔ;B2�W��A��@��)�iy�Ff�QEȜ,
�H��Q�/�`���|����՘T      �   �  x��X�n�F]����vTD�z�6A�Y$��e3�z�BRCV����sJ")�Df�� X�x�:��s.�qǸ��l���;��p��|%nJ`Ȩ� '�5��+���,��Y*FS�Q��/�/]8���𹫥����t�������������N����;K�4� Iv�Td�b�L񠘏��k$o��?��L�)�^��=�{ޕ�	����cy>�C:mߞ^�x�w='��B�&��� T<g��̂��B���*�v�������]8v�?嘶�e����Dq���v�ҍ�3���7Z�%���Ps�Ή�d���Š#!M$
Y�X^2���c	kx>���y]��ÈiWsD��[���� 8�����SU
�u���KV\�PV�=�S�}���M��������X���n�~X*M�WO�a�h 5�UʠsQ,JBi�QV�eDr�ˊj�h~9���w~�;�l�E�������x�0��&L�L%ə���S��Ze*d�N�.��ݡ^:�:��S';���Ni��$z�v~��`�Ccc*V14	*NDt�B�P2�:/I���t�C+��#1ì��,de8=��N���aJY�b�9^l���2b�[X8m?�|�. ee�k3���&}�=��Y�6 ���9�F�CC|j��x���˫j��NO;�m�jiZ��T�כ�͐Ӯ��~��F����T����L�0�9��52G�Y��
����ûOa�ű]��w�W�å���>w�۶:'�Z�=ƠWR���i1--`53�iH��U�կ���6���E�͂�?�b|f6fH	�h-q�qJ�9˒͚��0�%&�6EG%=�s؟c�%�>b|�ݕS�B�Ջ/���6; \��-��;��`7��ȿ��9&MS�V��3ek砵"�̵KB�d�\��Fɹ>Kٿ.���r_�w,��So��~����4���e 7���ހ <��PŸzglW\/gh�ꭲ�-Ҽ 4�z]�P,Y��!��f��p��I=��x�����饯�-���fKȕUzI�&�4�
q�ZI5����7��sJ�:�;鰟
qn���н���\S[�nC�ǜtj�:���*,7MS�Cl��KA�X�&z���L�f��\��,��Gm�;ս��W��T	�.�Le����h\օ�u�6u��L�=f��k�[�Ւ
�f������{�Q1�Yyo$�%���������p��} ��tF��@�
	��$`�
���"r�")����o���`�������{��qMv�U4jP��{�1[�O޷���O��(����%�X 7�(5	F_�N	h�Ts�'f�1~��U�jn|m��b�y�Q2�R�"w������
��D/Xj�{�3A14i��N�Y�^ey��r�垖��i���cB%���9���@K��m��(��޹kg,��#��ǎ\�J$ƾ�ցw�M�"����4�qx55�Y�{���z�� �c�R�9;��^\"D&F�b�ob����-���|� ��1��v��G4�� �ű6`D;x��IM�f��!/s�p8�4s��X��	 ��b6c�$�@�բH-Ai��%X��N|v#���*��2�}�r�8E����w��y����lMз�횅�}���n`�$%d�3�������,F�ɮ8]��I�Bt9�x�'�eM�w�0=����N�����
�X"�a�D�X`����7��>�4�o�+`*ZZ��͸5ߎ�tX��E�US�^�} Am�%TC�
S-8d5Ȃ��:E���)@��d����s��=��:W� v��la�v`[ИJ��e2`'��d\L}��6��~}kWsĥ���λ�&�
��qG���A��_�����6��-��@H6�"�>MX�5}���2��!���u�,d�CH��俇ĵ�B��/u��0=B��gayemn5� �cY��%[���ā��he̜�p��?OڦZXҦ����k�C���^ʬ�6�oV��>|��a}�     