User emacs-lisp files

Shoji Nishimura

��������

compilation-mode
  - compilation-mode�N�����̃o�b�t�@�̃R�[�f�B���O�V�X�e����SJIS�ɋ���
    - Windows��Ŏg�����Ƃ���
  - ImageMagick�̃p�X�̃n���h�����O
    - Meadow�́AImageMagic 6.2.8-Q16��v�����邪�Aruby��RMagic�͕ʂ̃o�[�W����
      �ŋ������o���Ȃ��B
      �V�X�e����PATH���ϐ��́ARMagic���v��������̂���ɗ���悤�ɂ���B
      meadow.bat�ŁAImageMagic 6.2.8-Q16��PATH���ϐ��̐擪�ɂ�Meadow���N��
      compilation-mode�ł́A�V�X�e����PATH���ϐ��ɖ߂����߁A�폜�B

snippet.el
  - snippet-cancel�̒ǉ��B
  �@- snippet��W�J������AC-g�ŃL�����Z���ł���悤�ɂ���B
    - hippie�W�J�Aabbrev�W�J�̗����őΉ��ł���悤�ɂ����B

flymake
  - flymake�ŃG���[��x�����o���Ƃ��A�~�j�o�b�t�@�[�ŕ\��
  - �ǂ������炻�̂܂܎����Ă���

�C���f���g
  - indent-current-buffer
    - �J�����g�o�b�t�@�S�̂��C���f���g�B�ȒP�Ȏ���
    - C-cC-i�ɃL�[�o�C���h
  - indent-or-complete
    - �󋵂ɂ��C���f���g���⊮
    - rails-emacs���甲������щ���
    - TAB�ɃL�[�o�C���h

hippie-exp
  - try-complete-abbrev
    - abbrev�ɓo�^����Ă��镶�����⊮���āA�����W�J
    - snippet.el��abbrev���o�^����Ă���ꍇ�̂݃e�X�g
    - snippet�̒�`���H�v����΁A���I�Ɏg���₷���Ȃ�B

ruby-mode
  - additional ruby-electric
    - ruby-electric-backspace/delete�͂ǂ�������̃R�s�[
    - ruby-electric-forward-char
      - ���͂������������łɓ��͂���Ă�����A�������͂����Ɉ�i��
      - ���łɕ��J�b�R���i�����Łj���͂���Ă���̂ɁA�i�蓮�Łj����
        ���Ă��܂����ꍇ�A�����Ă����B
    - compilation-mode
      - F5�ŃJ�����g�o�b�t�@��Ruby�X�N���v�g�����s
      - rakefile, specfile�Ȃǂ�F�����āArake, rspec�����ɋN��
    - snippet
      - �悭�g�������ȃp�^�[����ԗ�
      - rake, rspec, Test::Unit���ƂɃt�@�C���̎�ނɂ����
        snippet��؂�ւ���
    - flymake
      - ruby�p�̐ݒ�B�ǂ����炩�R�s�[


Snippet�̍����̃R�c

try-complete-abbrev�̕⊮���̏o�����̃��[���͓o�^���ꂽ���̂�
�@�Ō��ʂ����Ȃ����A�����ꍇ��alphabet��
�ƂȂ��Ă��܂��B
���̃N�Z�𗝉����č��ƁA���ʓI�ȕ⊮�����Ă����悤�ɂȂ�܂��B
�Ⴆ�΁A�Z���Ō��œr���܂œW�J�p�A���̂��قƂ�ǂ��Ȃ��W�J�p��
�Q�ʂ�p�ӂ���΁A���ʓI�ɍi�荞�݂Ȃ���̓W�J���o����ł��傤�B
�܂��A�W�J�̂������ɂ��낢��ȃo���G�[�V����������ꍇ�A
xx�Axx1�Axx2�̂悤�ɗp�ӂ��Ă����Ə��ԂɓW�J���Ă����Ă���܂��B
RSpec��Test::Unit�p��Snippet���Q�l�ɂ��Ă��������B
