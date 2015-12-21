# encoding: utf-8

describe RuboCop::Cop::RSpec::LineBetweenContexts do
  subject(:cop) { described_class.new }

  it 'enforces blank lines between contexts' do
    inspect_source(cop, ['describe MyClass do',
                         '  context "Some context" do',
                         '     it { does_something }',
                         '  end',
                         '  context "Some other context" do',
                         '    it { does_something }',
                         '  end',
                         'end'
                         ])
    expect(cop.offenses.size).to eq(1)
    expect(cop.offenses.map(&:line).sort).to eq([5])
    expect(cop.messages)
      .to eq(['Missing blank line between context blocks'])
  end

  it 'accepts context blocks that are separated by blank lines' do
    inspect_source(cop, ['describe MyClass do',
                         '  context "Some context" do',
                         '     it { does_something }',
                         '  end',
                         '',
                         '  context "Some other context" do',
                         '    it { does_something }',
                         '  end',
                         'end'
                         ])
    expect(cop.offenses).to be_empty
  end

  it 'does not inspect whitespaces before or after context blocks' do
    inspect_source(cop, ['describe MyClass do',
                         '',
                         '  context "Some context" do',
                         '     it { does_something }',
                         '  end',
                         '',
                         '  context "Some other context" do',
                         '    it { does_something }',
                         '  end',
                         '',
                         'end'
                         ])
    expect(cop.offenses).to be_empty
  end
end
