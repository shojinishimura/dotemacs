;;; yasnippet for RSpec
;;;
;;; Shoji Nishimura (shoji_n@muc.biglobe.ne.jp)
;;; 2008/06/24

(defun ruby-rspec-mode-p ()
  (string-match ".*_spec\\.rb$" (file-name-nondirectory (buffer-file-name))))

(defun ruby-after-should-p ()
  (string-match "\\(should\\|should_not\\)\\s +\\S +"
                (current-line-string)))

;; snippet
(yas/define-snippets
 'ruby-mode
 '(
   ("describe" "describe ${1:Class} do\n  $0\nend" "describe context do ... end" (ruby-rspec-mode-p))
   ("describe.1" "describe \"${1:context}\" do\n  $0\nend" "describe context do ... end" (ruby-rspec-mode-p))
   ("describe.2" "describe ${1:Class}, \"${2:context}\" do\n  $0\nend" "describe context do ... end" (ruby-rspec-mode-p))
   ("it" "it \"should ${spec}\" do\n  $0\nend" "it \"should ...\" do ... end" (ruby-rspec-mode-p))
   ("it_should_behave_like" "it_should_behave_like ${example}" "it_should_behave_like example" (ruby-rspec-mode-p))
   ("share_examples_for" "share_examples_for \"${name}\" do\n  $0\nend" "share_examples_for \"name\"" (ruby-rspec-mode-p))
   ("share_as" "share_as :${name} do\n  $0\nend" "share_as name do ... end" (ruby-rspec-mode-p))
   ("before" "before do\n  $0\nend" "before do ... end" (ruby-rspec-mode-p))
   ("before.1" "before :each do\n  $0\nend" "before :each do ... end" (ruby-rspec-mode-p))
   ("before.2" "before :all do\n  $0\nend" "before :all do ... end" (ruby-rspec-mode-p))
   ("after" "after do\n  $0\nend" "after do ... end" (ruby-rspec-mode-p))
   ("after.1" "after :each do\n  $0\nend" "after :each do ... end" (ruby-rspec-mode-p))
   ("after.2" "after :all do\n  $0\nend" "after :all do ... end" (ruby-rspec-mode-p))
   ("sh" "should $0" "should ..." (ruby-rspec-mode-p))
   ("should" "should $0" "should ..." (ruby-rspec-mode-p))
   ("shn" "should_not $0" "should_not ..." (ruby-rspec-mode-p))
   ("should_not" "should_not $0" "should_not ..." (ruby-rspec-mode-p))
   ("pending" "pending(\"${message}\"" "pending message" (ruby-rspec-mode-p))
   ("pending.1" "pending(\"${message}\") do\n  $0\nend" "pending message do ... end" (ruby-rspec-mode-p))
   ("violated" "violated(\"${message}\")" "violated message" (ruby-rspec-mode-p))
   ("shb" "should be_" "should be_..." (ruby-rspec-mode-p))
   ("shnb" "should_not be_" "should_not be_..." (ruby-rspec-mode-p))
   ("be_true" "be_true" "be_true" (ruby-rspec-mode-p))
   ("shbt" "should be_true" "should be_true" (ruby-rspec-mode-p))
   ("snbt" "should_not be_true" "should_not be_true" (ruby-rspec-mode-p))
   ("be_false" "be_false" "be_false" (ruby-rspec-mode-p))
   ("shbf" "should be_false" "should be_false" (ruby-rspec-mode-p))
   ("shnbf" "should_not be_false" "should_not be_false" (ruby-rspec-mode-p))
   ("be_a_kind_of" "be_a_kind_of(${klass})" "be_a_kind_of Class" (ruby-rspec-mode-p))
   ("shbk" "should be_a_kind_of(${klass})" "should be_a_kind_of Class" (ruby-rspec-mode-p))
   ("shnbk" "should_not be_a_kind_of(${klass})" "should_not be_a_kind_of Class" (ruby-rspec-mode-p))
   ("be_an_instance_of" "be_an_instance_of(${klass})" "be_an_instance_of Class" (ruby-rspec-mode-p))
   ("shbi" "should be_an_instance_of(${klass})" "should be_an_instance_of Class" (ruby-rspec-mode-p))
   ("shnbi" "should_not be_an_instance_of(${klass})" "should_not be_an_instance_of Class" (ruby-rspec-mode-p))
   ("sheq" "should == ${obj}" "should == obj" (ruby-rspec-mode-p))
   ("shneq" "should_not == ${obj}" "should_not == obj" (ruby-rspec-mode-p))
   ("eql" "eql(${expected})" "eql expected" (ruby-rspec-mode-p))
   ("sheql" "should eql(${expected})" "should eql expected" (ruby-rspec-mode-p))
   ("shneql" "should_not eql(${expected})" "should_not eql expected" (ruby-rspec-mode-p))
   ("equal" "equal(${expected})" "equal expected" (ruby-rspec-mode-p))
   ("shequal" "should equal(${expected})" "should equal expected" (ruby-rspec-mode-p))
   ("shnequal" "should_not equal(${expected})" "should_not equal expected" (ruby-rspec-mode-p))
   ("be_close" "be_close(${expected}, ${delta})" "be_close expected, delta" (ruby-rspec-mode-p))
   ("shbc" "should be_close(${expected}, ${delta})" "should be_close expected, delta" (ruby-rspec-mode-p))
   ("shnbc" "should_not be_close(${expected}, ${delta})" "should_not be_close expected, delta" (ruby-rspec-mode-p))
   ("be_empty" "be_empty" "be_empty" (ruby-rspec-mode-p))
   ("shbe" "should be_empty" "should be_empty" (ruby-rspec-mode-p))
   ("shnbe" "should_not be_empty" "should_not be_empty" (ruby-rspec-mode-p))
   ("be_nil" "be_nil" "be_nil" (ruby-rspec-mode-p))
   ("shbn" "should be_nil" "should be_nil" (ruby-rspec-mode-p))
   ("shnbn" "should_not be_nil" "should_not be_nil" (ruby-rspec-mode-p))
   ("match" "match(${regexp})" "match regexp" (ruby-rspec-mode-p))
   ("shm" "should match(${regexp})" "should match regexp" (ruby-rspec-mode-p))
   ("shnm" "should_not match(${regexp})" "should_not match(regexp)" (ruby-rspec-mode-p))
   ("include" "include(${*members})" "include(member)" (ruby-rspec-mode-p))
   ("shi" "should include(${*members})" "should include(member)" (ruby-rspec-mode-p))
   ("shni" "should_not include(${*members})" "should_not include(member)" (ruby-rspec-mode-p))
   ("shh" "should have_" "should have_" (ruby-rspec-mode-p))
   ("shnh" "should_not have_" "shold_not have_" (ruby-rspec-mode-p))
   ("have" "have(${number}).items" "have(number).items" (ruby-rspec-mode-p))
   ("have_" "have(${number}).items" "have(number).items" (ruby-rspec-mode-p))
   ("shhi" "should have(${number}).items" "should have(number).items" (ruby-rspec-mode-p))
   ("shnhi" "should_not have(${number}).items" "should_not have(number).items" (ruby-rspec-mode-p))
   ("have_at_least" "have_at_least(${number}).items" "have_at_least(number).items" (ruby-rspec-mode-p))
   ("shhl" "should have_at_least(${number}).items" "should have_at_least(number).items" (ruby-rspec-mode-p))
   ("shnhl" "should_not have_at_least(${number}).items" "should_not have_at_least(number).items" (ruby-rspec-mode-p))
   ("have_at_most" "have_at_most(${number}).items" "have_at_most(number).items" (ruby-rspec-mode-p))
   ("shhm" "should have_at_most(${number}).items" "should have_at_most(number).items" (ruby-rspec-mode-p))
   ("shnhm" "should_not have_at_most(${number}).items" "should_not have_at_most(number).items" (ruby-rspec-mode-p))
   ("have_key" "have_key(${member})" "have_key(member)" (ruby-rspec-mode-p))
   ("shhk" "should have_key(${member})" "should have_key(member)" (ruby-rspec-mode-p))
   ("shnhk" "should_not have_key(${member})" "should_not have_key(member)" (ruby-rspec-mode-p))
   ("raise_error" "raise_error(${named_error}, ${*str/regexp})" "raise_error error, str/regexp" (ruby-rspec-mode-p))
   ("shre" "should raise_error(${named_error}, ${*str/regexp})" "should raise_error error, str/regexp" (ruby-rspec-mode-p))
   ("shnre" "should_not raise_error(${named_error}, ${*str/regexp})" "should_not raise_error, str/regexp" (ruby-rspec-mode-p))
   ("throw_symbol" "throw_symbol(${*symbol})" "throw_symbol symbol" (ruby-rspec-mode-p))
   ("shts" "should throw_symbol(${*symbol})" "should throw_symbol(symbol)" (ruby-rspec-mode-p))
   ("shnts" "should_not throw_symbol(${*symbol})" "should_not throw_symbol(symbol)" (ruby-rspec-mode-p))
   ("satisfy" "satisfy { |actual|\n  $0\n}" "satisfy {|actual| ... }" (ruby-rspec-mode-p))
   ("shsat" "should satisfy { |actual|\n  $0\n}" "should satisfy { |actual| ... }" (ruby-rspec-mode-p))
   ("shnsat" "should_not satisfy { |actual|\n  $0\n}" "should_not satisfy { |actual| ... }" (ruby-rspec-mode-p))
   ("ch" "change {\n  $0\n}" "change { ... }" (ruby-rspec-mode-p))
   ("chby" "change {\n  $0\n}.by(${value})" "change { ... }.by(value)" (ruby-rspec-mode-p))
   ("chft" "change {\n  $0\n}.from(${old}).to(${new})" "change { ... }.from(old).to(new)" (ruby-rspec-mode-p))
   ("shc" "should change {\n  $0\n}" "should change { ... }" (ruby-rspec-mode-p))
   ("shcb" "should change {\n  $0\n}.by(${value})" "should change { ... }.by(value)" (ruby-rspec-mode-p))
   ("shcft" "should change {\n  $0\n}.from(${old}).to(${new})" "should change { ... }.from(old).to(new)" (ruby-rspec-mode-p))
   ("shnc" "should_not change {\n  $0\n}" "should_not change { ... }" (ruby-rspec-mode-p))
   ("respond_to" "respond_to(${*names})" "respond_to(name1, ...)" (ruby-rspec-mode-p))
   ("shrt" "should respond_to(${*names})" "should respond_to(name1, ...)" (ruby-rspec-mode-p))
   ("shnrt" "should_not respond_to(${*names})" "should_not respond_to(name, ...)" (ruby-rspec-mode-p))
   ("steps_for" "steps_for(:${story}) do\n  $0\nend" "steps_for(story) do ... end" (ruby-rspec-mode-p))
   ("Given" "Given(\"${msg}\") do |${args}|\n  $0\nend" "Given(message) do |args| ... end" (ruby-rspec-mode-p))
   ("When" "When(\"${msg}\") do |${args}|\n  $0\nend" "When(message) do |args| ... end" (ruby-rspec-mode-p))
   ("Then" "Then(\"${msg}\") do |${args}|\n  $0\nend" "Then(message) do |args| ... end" (ruby-rspec-mode-p))
   ("with_steps_for" "with_steps_for :${story} do\nrun '${file}'\nend" "with_steps_for :story do run 'file' end" (ruby-rspec-mode-p))
   )
 'text-mode)

;; hook
(defun my-rspec-find-file-hook ()
  (when (string-match "_spec\\.rb$" buffer-file-name)
    (setq compile-command (concat "spec " (buffer-file-name) " "))))

(add-hook 'find-file-hook
          'my-rspec-find-file-hook)
