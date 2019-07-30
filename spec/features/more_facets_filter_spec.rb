require 'spec_helper'

RSpec.feature 'More facets modal', js: true do
  before do
    visit '/catalog/facet/dct_provenance_s?q=&search_field=all_fields'
  end

  it 'filters a value in the more facet modal' do
    ul_count = page.all('ul .facet-label').count
    filter = find_field(id: 'filterInput')
    filter.fill_in(with: 'co')
    ul_filtered = page.all('ul .facet-label')
    expect(ul_filtered.count).to be < ul_count
  end
end
