# Helper methods defined here can be accessed in any controller or view in the application

module Fuitter
  class App
    module PageHelper
      def get_data_for_home
        facebook_page = FacebookPage.find(id: params['id'])
        facebook_page.about ? facebook_page : nil
      end

      def get_data_for_news
        facebook_page = FacebookPage.find(id: params['id'])
        page_feed = facebook_page.page_feeds
        page_feed.empty?? nil : page_feed
      end

      def get_data_for_about
        get_data_for_home
      end

      def get_data_for_contact
        get_data_for_home
      end

      def get_data_for_gallery
        facebook_page = FacebookPage.find(id: params[:id])
        albums = facebook_page.albums
        albums.any? ? albums : nil
      end

      def list_photos
        album = Album.find(id: params[:album_id])
        album.pictures
      end

      def page_token
        FacebookPage.where(id: params['id']).get(:token)
      end

      def save_albums(albums, obj)
        facebook_page = FacebookPage.find(id: params[:id])
        albums.each do |album|
          id = facebook_page.add_album(name: album['name']).id
          find_large_image_url(obj,album,id)
        end
        get_data_for_gallery
      end

      def find_large_image_url(obj,album,id)
        fields = {fields: 'webp_images'}
        photos =  obj.get_connection(album['id'],'photos',fields)
        photos.each do |v|
          # find the sum of height and width of each image collection to return the image with higher resolution
          sum = v['webp_images'].map { |v| v['height'] + v['width']}
          index = sum.each.with_index.max[1]
          img = v['webp_images'][index]['source']
          save_photos(id,img)
        end
      end

      def save_photos(id,img)
        album = Album.find(id: id)
        album.add_picture(url: img)
      end


    end

    helpers PageHelper
  end
end