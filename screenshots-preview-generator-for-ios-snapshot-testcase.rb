#!/usr/bin/env ruby

PATTERN_OF_OS_VERSION = %r{\d+_\d+}
PATTERN_OF_SCREEN_SIZE = %r{\d+x\d+}
NUMBER_OF_ROWS = 5

# Change here for number of your test case
NUMBER_OF_COLUMNS = 2

# Change here in your favor
IMAGE_WIDTH = 100

def createMarkdown
    # Change here for your test scheme name
    scheme = 'MVVMArchitectureTemplateTests'

    reference_image_dir = "./#{scheme}/TestSnapshot/ReferenceImages_64/*"

    Dir.glob(reference_image_dir).sort.each do |test_file_path|
        markdowns = ""
        test_title = test_file_path.split("/").last
        markdowns += "# #{test_title}\n\n"
        reference_image_path = "#{test_file_path}/*"

        Dir.glob(reference_image_path).sort.each_slice(NUMBER_OF_COLUMNS) do |slice|
            rows = Array.new(NUMBER_OF_ROWS) { Array.new(0, 0) }

            slice.each do |screenShot|
            tokens = screenShot[/test(.+)/, 1].split("_")
            header = tokens[1]
            postfix = tokens[2..].join("_")
            os = postfix.match(PATTERN_OF_OS_VERSION)[0].gsub('_', '.')
            screenSize = convertScreenSizeIntoDeviceName(postfix.match(PATTERN_OF_SCREEN_SIZE)[0])
            src = "../#{screenShot[/.\/#{scheme}\/(.+)/, 1]}"
            imageTag = "<img src='#{src}' width='#{IMAGE_WIDTH}' style='border: 1px solid #999' />"


            rows[0].push header
            rows[1].push ":---:"
            rows[2].push os
            rows[3].push screenSize
            rows[4].push imageTag
        end

        markdowns += rows.map { |row| row.join('|').prepend('|').concat('|') + "\n" }.join
        markdowns += "\n"
    end

    report_file_path = "./#{scheme}/Reports/#{test_title}.md"

    status = FileTest.exist?(report_file_path) ? "UPDATED" : "CREATED"

    File.write(report_file_path, markdowns)
        puts "[#{status}] #{report_file_path}"
    end
end

def convertScreenSizeIntoDeviceName(screenSize)
    case screenSize
    when "320x568"
        return 'iPhone SE'
    when "375x667"
        return 'iPhone 6'
    when "414x736"
        return 'iPhone 8 Plus'
    when "375x812"
        return 'iPhone XS'
    when "414x896"
        return 'iPhone XS Max'
    else
        return 'iPhone'
    end
end

puts '[START] Generating Screenshots Preview'
createMarkdown
puts '[FINISH] Generating Screenshots Preview'