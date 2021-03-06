shared_examples 'a website with news list' do
  it 'should contain at least one post' do
    within '#main' do
      expect(all('.row.news').length).to be >= 1
    end
  end

  it 'each post should have avatar, post excerpt, description and title Read more... button' do
    within '#main' do
      all('.row.news').each do |news|
        expect(news).to have_content('Read more...')
        expect(news).to have_css('img.img-circle')
        expect(news).to have_css('.description')
        expect(news).to have_css('h5')
      end
    end
  end

  it 'should show post content after click on Read more... and hide it after another click', js: true do
    within '#main' do
      random_news = all('.row.news').sample
      expect(random_news.find('.post-content').text).to be_empty
      expect(random_news.find('.post-excerpt').text).to_not be_empty
      random_news.click_on('Read more...')
      wait_for_ajax
      expect(random_news.find('.post-content').text).not_to be_empty
      expect(random_news.find('.post-excerpt').text).not_to be_empty
      expect(random_news).to have_content('Hide more...')
      random_news.click_on('Hide more...')
      expect(random_news).to have_content('Show more...')
    end
  end
end
