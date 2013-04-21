require 'spec_helper'

describe Webern::Row do
  describe 'complete integer row' do
    # Concerto for Nine Instruments, Op. 24
    let(:row) { create_row(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9) }

    describe '#zero' do
      it 'should return the row normalized to start on 0' do
        expect(row.zero).to eq [0, 11, 3, 4, 8, 7, 9, 5, 6, 1, 2, 10]
      end
    end

    describe 'transformations' do
      before { row.zero! }
      it 'should invert correctly' do
        expect(row.inversion).to eq [0, 1, 9, 8, 4, 5, 3, 7, 6, 11, 10, 2]
      end

      it 'should retrograde correctly' do
        expect(row.retrograde).to eq [10, 2, 1, 6, 5, 9, 7, 8, 4, 3, 11, 0]
      end

      it 'should retrograde-inversion correctly' do
        expect(row.retrograde_inversion).to eq [2, 10, 11, 6, 7, 3, 5, 4, 8, 9, 1, 0]
      end

      it 'should transpose correctly' do
        expect(row.transpose(2)).to eq [2, 1, 5, 6, 10, 9, 11, 7, 8, 3, 4, 0]
      end
    end
  end

  describe 'incomplete integer row' do
    # String Quartet, Op. 28
    let(:row) { create_row(10, 9, 0, 11, 3, 4, 1, 2) } # actual ending: 6, 5, 8, 7

    describe 'row completion' do
      it 'should complete the row in ascending order of remaining pitches' do
        expect(row).to eq [10, 9, 0, 11, 3, 4, 1, 2, 5, 6, 7, 8]
      end
    end

    describe '#zero' do
      it 'should return the row normalized to start on 0' do
        expect(row.zero).to eq [0, 11, 2, 1, 5, 6, 3, 4, 7, 8, 9, 10]
      end
    end

    describe 'transformations' do
      before { row.zero! }
      it 'should invert correctly' do
        expect(row.inversion).to eq [0, 1, 10, 11, 7, 6, 9, 8, 5, 4, 3, 2]
      end

      it 'should retrograde correctly' do
        expect(row.retrograde).to eq [10, 9, 8, 7, 4, 3 ,6, 5, 1, 2, 11, 0]
      end

      it 'should retrograde-inversion correctly' do
        expect(row.retrograde_inversion).to eq [2, 3, 4, 5, 8, 9, 6, 7, 11, 10, 1, 0]
      end

      it 'should transpose correctly' do
        expect(row.transpose(2)).to eq [2, 1, 4, 3, 7, 8, 5, 6, 9, 10, 11, 0]
      end
    end
  end

  def create_row(*args)
    Webern::Row.new(*args)
  end
end
